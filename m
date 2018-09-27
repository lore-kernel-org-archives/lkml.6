Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29125C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5A8216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Vv4eeVDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5A8216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeI1CDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:03:12 -0400
Received: from mail-sn1nam02on0117.outbound.protection.outlook.com ([104.47.36.117]:63000
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727266AbeI1CDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mEnHpqjxromCa7EQ6VkJ1/aWsEmYPnCPJuEGJy6n4I=;
 b=Vv4eeVDQJ9WpPzVgSQfD15rbGKlYXDPnNfv7OACN7DeFa1HjAh+/7Jqq9PYBVq09d7T2zFgqOouTVlPNqhXLI1TLiD29KJUt5oXQi5tY2mCh/d/VH9Y2dBSYfm6lL4NWRyNaIO40n9pK9dCIURDZp6UfNEexmsJDa2a+65Fyk/A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Thu, 27 Sep 2018 19:43:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.011; Thu, 27 Sep 2018
 19:43:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH AUTOSEL 4.14 87/87] PCI: Whitelist Thunderbolt ports for
 runtime D3
Thread-Topic: [PATCH AUTOSEL 4.14 87/87] PCI: Whitelist Thunderbolt ports for
 runtime D3
Thread-Index: AQHUTjL8aFGgHYst30uDQLUO80aa4KT0I6GAgBB0pAA=
Date:   Thu, 27 Sep 2018 19:43:18 +0000
Message-ID: <20180927194316.GB9157@sasha-vm>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
 <20180917030220.245686-87-alexander.levin@microsoft.com>
 <20180917082539.pikwd2n27ah6xy35@wunner.de>
In-Reply-To: <20180917082539.pikwd2n27ah6xy35@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:OGdddXXbb3Bkm8sRO2C+A9BJxm3NbFn92jDYcG7+EA37L5OSSEbHdKcpBVjBy/LdxvUQjuVsx/czxqXwOiSHc+xAydiiHNbqcp3DanVDrgqjXixgegqhWfp8asnI3afJ8IrqDgBbwc5M0CVQB68rr5QCSK2tuaE0Q5gywJM9Ei8o/z4faay+AjGtYv1fK5AjzJzGEwE+dXNAATXskgG13U934e9ENxaRFKOcGQqd0Yfy/5UsGSAGkXXahZyCKguw92waz56VR1ABBsI0tleNnWSpnsLfnSwbx3WAT3F3vSJOfXdSGtakE0xSgyuviCit7P1xvPSDt1heTtoqDacc9L72+EDDGEoSmxdMt2bZ87meqw/ngRDEXPwWl54FGySTJZpr4jklguNSIyMc0MQrhBhA9pFm1oYDWthvC4UO/EqWEV8N91bxXZVJ9erzSxOek+uH1wQdlvEeQihqoqzPaQ==;5:5041NjKSxpSlbVWgRVbr2KTrC+AZ06n6VpXJtLzR3j5VqVwrbtV5DXU/dXAsdk0t4CoGyDRfZ1fDo25jGW5O/+7gRCOrKNBYiGxrnE5hpTSY/etErIJKbhuqu6cKVpPKIOmUabe0bFs8JKTOYvL1rcq4/OwiB/ka6DPdm88f9a8=;7:TzUcCUwl3jqN09ne9s48XM2o+kRj7rZqRPGu4YGT2LXxS1O/7FQxrt0CkBYQwgoULAxsBBAYqSX5ulj0dxVqhZKvbIf4Z8b9585CRXwhLYQlMMCrKlkUtLaYGHySAkTfmfDj2B4r2/NGqPDF/Nt8beoDv/vNuHqRW/FGPFWQppDn8Ln3yLeRxFcHirkACdcF5W5CjUlyqbPQ9PQxQ3eKr2ck+zv5DQN9q02SC02d0y8M9wa4SADnnQ0unt2CNFHx
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8ba4777b-61c3-46c9-daa0-08d624b179bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773F4165BD7917E84E57F34FB140@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(136003)(396003)(366004)(39860400002)(346002)(189003)(199004)(217873002)(316002)(6436002)(68736007)(9686003)(6512007)(186003)(53936002)(54906003)(102836004)(81166006)(81156014)(8936002)(25786009)(10090500001)(5250100002)(34290500001)(1076002)(71190400001)(2906002)(6116002)(3846002)(14444005)(256004)(97736004)(71200400001)(2900100001)(11346002)(476003)(105586002)(106356001)(33656002)(39060400002)(14454004)(6916009)(6246003)(508600001)(10290500003)(72206003)(33896004)(5660300001)(6486002)(4326008)(99286004)(229853002)(86362001)(6506007)(446003)(66066001)(305945005)(7736002)(86612001)(26005)(76176011)(8676002)(486006)(22452003)(33716001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Kbua6TP3kepXnyFyQYQ8LX+x0Gi1HYDYMiNyNoUfzSvTuyqqFH3Ae8IpvpCcmUa2To7KI0wS1tRd9T79+8GFCyu/MilKGUqCldXtQY8X361e54LrYk5m5FnNZCiye64/FveWzjfJnA36WCq8JbHKuWPKSGYT2gtIpgEt7HzvrqLScy6uPMo1MdNNABuMCNUz3+wQ1ONXhnDo4liCvKaZ6OSqtGObiFrq89Sqfk2OyoyVEL1QPTEAFXWVLJ106RUnSj/PKH9vTrNnZk/CQzfPTWsZzvOhdYGl67zrggt/Keapa3gJLZtbtWUWyKcaU2x/IgnJ2dvUjUd4Pud69ukPV+1u6usI3NxrBF+QbIZRU4E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <358ACED3B3D95C4DA504C4C3F3446BB0@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba4777b-61c3-46c9-daa0-08d624b179bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 19:43:18.9070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 10:25:39AM +0200, Lukas Wunner wrote:
>Hi Sasha,
>
>On Mon, Sep 17, 2018 at 03:03:19AM +0000, Sasha Levin wrote:
>> From: Lukas Wunner <lukas@wunner.de>
>>
>> [ Upstream commit 47a8e237ed443c174f8f73402755c458c56eb611 ]
>>
>> Thunderbolt controllers can be runtime suspended to D3cold to save ~1.5W=
.
>> This requires that runtime D3 is allowed on its PCIe ports, so whitelist
>> them.
>
>This commit was at the end of a series with 30+ patches and depends on
>all the preceding patches.  It cannot be backported on its own I'm afraid,
>hence should be removed from the 4.14 and 4.18 stable queue.

I'll remove it, thanks!=
