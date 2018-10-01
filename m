Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27C0C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A08B208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SOMa0NJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A08B208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbeJBDUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:20:02 -0400
Received: from mail-bl2nam02on0101.outbound.protection.outlook.com ([104.47.38.101]:17888
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbeJBDUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCSct/Ewh4cvMJ92P73OG3n6UYNGx9N/kEcRCnCUq14=;
 b=SOMa0NJ3yo4eQHjt6rHWWxi2CPmb+cuuAyE+TFaGdpPhGUYaDd9DuBnF+Nl0uv9RKfKazX7KVfBFlKQvWBLbmgqxATn5tXmh/rUShiYtcmoo8XC15LdD2E6NifBcUeW1vCjOeQr+m+BKqLlV+WM2N5Q0sG2ntBLhHuMUkefBIps=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0759.namprd21.prod.outlook.com (10.173.192.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1207.11; Mon, 1 Oct 2018 20:40:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.007; Mon, 1 Oct 2018
 20:40:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Daniel Wang <wonderfly@google.com>
CC:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "byungchul.park@lge.com" <byungchul.park@lge.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "penguin-kernel@i-love.sakura.ne.jp" 
        <penguin-kernel@i-love.sakura.ne.jp>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Thread-Topic: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Thread-Index: AQHUVpq/zmV6u4og3kyAk66PvwoYTaUKyzsAgAAUtACAAADNAA==
Date:   Mon, 1 Oct 2018 20:40:24 +0000
Message-ID: <20181001204022.GE69414@sasha-vm>
References: <20180927194601.207765-1-wonderfly@google.com>
 <20181001152324.72a20bea@gandalf.local.home>
 <CAJmjG29Jwn_1E5zexcm8eXTG=cTWyEr1gjSfSAS2fueB_V0tfg@mail.gmail.com>
In-Reply-To: <CAJmjG29Jwn_1E5zexcm8eXTG=cTWyEr1gjSfSAS2fueB_V0tfg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0759;6:9Ms/1cgGQpssn84fGMOH+XoCP9HlN8gWYnyBLC0c8lZOtxjTdfxnH3s+3G0nuNVvrj+Tp5GD9oE3vEMVOK+O6Sv1QDyomaEaknPxMC1N/dPD2FYVJPx3f0J7R+LkSBEBz6L08i1U1W0j6a867z5JIqN8mOJ6bK0ERtwuBUao53fLfHS6uYsdrN67s02fHr1jG1rAiWeZVjgH4fdUsmzDXTblYxsuox1q7M96gKuizbrE5+aXFUl1EvtI8hRI/dQ18ThQhOWbWk5ktczG0ZYxPJ7C57cEuj8NuLW0AzURVOnb3ZweMPaHtmSMkUeOF1EjorI9nvwhAEd9Kp+Fkc1VX+fNruMWM+j5v8uKrbp7yl268hNY0cwjTNQPtaG4HwUGz4wIICgdB0YKnt+gNA72cfYEUlK8g7YN8nCdFGdhd1kixJ+AWCLf77cVbTuUIbuERRhe/dHQcl4333uCeIAJJQ==;5:sAaQBlbCjb71jes/0IfAVVAR8deWK5AGq6Vyrvn76yI7cMfQZsGNZ5sFIGvBGMKXJszuMH0eemVNuWTMTrIGzAVAPF62t+pwvH+rJqiYJVTW9PWC6oxAqLRZnmTmgX1YG0imw3Bita+/CCelIPP6heA4m/6BDTcLpznwzalWcw0=;7:TgEUiAFJf8Hz0Qojr3nlQaDbDdwjrcroTtBNXpqCL6khW6ufiKu0bFShILyjbUlD6fOKH/lSQF5nTcihkKrl1EdQOAIF+5rp2Pgryqy/ECblUcleSz+k2TR+YS+OtZTJj5KSjuxAq3/B2+dHcMYPNUiME8PiU5Wx2zYp4cSBL5fs+5sAKu78Ama2CsPqTm+Y+5qmIf5X50xAuElseHwVwev4G5/w42QRdS8nmGlBy7v5ri3leJCPWfE6w/WUU1z8
x-ms-office365-filtering-correlation-id: 4976d0a3-051d-4c18-39ec-08d627de1d73
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0759;
x-ms-traffictypediagnostic: CY4PR21MB0759:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0759C30A9F30A9E993173D0FFBEF0@CY4PR21MB0759.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0759;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(136003)(376002)(396003)(366004)(39860400002)(199004)(189003)(14454004)(33896004)(76176011)(6506007)(6246003)(54906003)(39060400002)(256004)(14444005)(105586002)(25786009)(81156014)(8676002)(81166006)(106356001)(11346002)(2900100001)(4326008)(476003)(8936002)(68736007)(486006)(33716001)(5250100002)(446003)(99286004)(7416002)(97736004)(6512007)(9686003)(316002)(5660300001)(7736002)(305945005)(229853002)(66066001)(53936002)(33656002)(6436002)(10090500001)(6486002)(10290500003)(86612001)(2906002)(478600001)(6916009)(1076002)(86362001)(186003)(3846002)(6116002)(26005)(102836004)(71200400001)(22452003)(72206003)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0759;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tOCWRTDXRZtpiLvpOJnhP22bfH4i8NMykBmvl3CCS0DQ1FT+pnZHNhFGGdD+wbviKsJYgnd8/yt+xED/PcuBdOANWP5hdc/b32eXos48vkfKqbj4Od2Wq70YUW+LdB/II58RSfeOrtrk/MuC/hh0ndrvU51SPYEkP8/47DpRRNqSYgJ8f5tGmBKdI+1S6AUxXCWrvJjdpi4AIgjN7yPs3/acU9iuehVVD6dDl4UlmCl5kZqQJMrpMM9mpSzxkfPQcG8C4yqBya06cVQveJIbsrt0y2U0ZfqClhA4BxEDUXBtc4Qk6a1vmMVXueb+Ptjbx/J2iTYN5fwBR7NM/Mv0DypSY4hXf86mdS1SA+ezdgY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <748043772AB90F488DD1B400A54E69CC@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4976d0a3-051d-4c18-39ec-08d627de1d73
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 20:40:24.7835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 01:37:30PM -0700, Daniel Wang wrote:
>On Mon, Oct 1, 2018 at 12:23 PM Steven Rostedt <rostedt@goodmis.org> wrote=
:
>>
>> > Serial console logs leading up to the deadlock. As can be seen the sta=
ck trace
>> > was incomplete because the printing path hit a timeout.
>>
>> I'm fine with having this backported.
>
>Thanks. I can send the cherrypicks your way. Do you recommend that I
>include the three follow-up fixes though?
>
>c14376de3a1b printk: Wake klogd when passing console_lock owner
>fd5f7cde1b85 printk: Never set console_may_schedule in console_trylock()
>c162d5b4338d printk: Hide console waiter logic into helpers
>dbdda842fe96 printk: Add console owner and waiter logic to load
>balance console writes

Maybe it'll also make sense to make the reproducer into a test that can
go under tools/testing/ and we can backport that as well? It'll be
helpful to have a way to make sure things are sane.

--
Thanks,
Sasha=
