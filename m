Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8E7C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C41F20833
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Tda/FlCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C41F20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeIYEoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:44:24 -0400
Received: from mail-dm3nam03on0098.outbound.protection.outlook.com ([104.47.41.98]:40359
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726389AbeIYEoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4f5Jesgq8dukxm9yzSCY0J4sWa7bRVU+e1sG6rAjVzA=;
 b=Tda/FlCXx5Qr5j4Ijx0DDHxfD45j9oDjs1UfSRhp++aBRsmoT2/CGUznEG4n3z2jjv5RRfVfLWwdpLPi691UYZ6JeZIK060zO8nBnCaF/rV7It1cZs4wQ0qZvQix1V7dxgpeUuSBHR0Uy7FgJ7vGrR5ovCgP2qcMvzqu3nZv8+s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 24 Sep 2018 22:39:53 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 22:39:53 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Joe Perches <joe@perches.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 3.18 104/105] IB/nes: Fix a compiler warning
Thread-Topic: [PATCH 3.18 104/105] IB/nes: Fix a compiler warning
Thread-Index: AQHUU/wkJKE2U0eR00y1A2EiQ1waIaT/og8AgAAWhQCAAAE6gIAATT0A
Date:   Mon, 24 Sep 2018 22:39:53 +0000
Message-ID: <20180924223952.GA9157@sasha-vm>
References: <20180924113113.268650190@linuxfoundation.org>
 <20180924113123.002918395@linuxfoundation.org>
 <6f7ca3c205bada768c3918b1feacbbd5ce23a64d.camel@perches.com>
 <20180924175902.GB19402@kroah.com>
 <6d6f31c87b0c9b1a551d352439183c8c9c4df04c.camel@perches.com>
In-Reply-To: <6d6f31c87b0c9b1a551d352439183c8c9c4df04c.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:hwXb9Kib3Hy7r5bi4t1tDSqv6ngFVzjA2hzkyyWjQhkujI8eQRBGQ4xhyxrl+0475rFBgm6/1xnMihOjkQDXbjaGgrnaHqctvP74kvKsP7qxpXMePxMhRri+Cn8b2P7Sua518bZVqBRmPKJ9amtRaRzaQKZp/mVSagv4aIsYv3doC1RnibysWIAphjNCQ+wgvTEnYlC7vN2xXOaIlj59Ehaxon8d79l7lazV+CplAkVE55uqI0ayVtIqdhRM+ByiZPuGD3+cpESRl+8zJ9QDN+FM9/UABgQ4TSBKZF2vLZO/3iDm+undhXJ8aTemR4n3vwoM0yaf5tIGfvUZSvqLXo6KEM8T9Yz2LDcrm/LQAdPwESy0DzMCeUfLbpSucbGl3vI25IkOj3xrs+lPNSrhkzg5lZb/rXiYFpCIFCrkicytmZDT+rYzQ6lYI6wD4oTZbCSkzxs1tTTtgMjg2SQq9g==;5:mQAURwgpwUGz9B9XqbKeuerfZE2Qq7OdQVZSIAz44KP4xc5eytqOJGbICBjylgsXOGLWwv5dsZgXNexkGDunbU5uGKzqfNCCzwsKAL3IBx6x7K5lA0U+1XDQjyHPlrnd4ySGfEuZCVypB7HI+zXyRVGx/F6U0vRHWgpP/tTMJE8=;7:CN3TML/L8lgMbEcC1Bdi2h0j2SmWbNwrq1ygHQNQZIf/rs8o1hXu5ut9KAqgaLIY25BScGFh7XAZHI1hPcMUbtvLB3V+BSyPf240jiLxB2o+ztTZBxSOMGLIUXEWAsD0RJTMUGmCCR0PEIJ/bfTECkcEIvvaptQG6C57hIAtvT5gvnk+IAC/VuWUlQ/whPuuCZhCijio6vwrCc9JOcvZFl4uKLErNjhBEIW7K07hABOhujv+wIJ3a9b46pPmVIv1
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 21d6749d-ed63-4127-6806-08d6226ea568
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
x-microsoft-antispam-prvs: <CY4PR21MB0856273C9EF7886B95211A99FB170@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(346002)(136003)(376002)(366004)(39860400002)(199004)(189003)(305945005)(97736004)(7736002)(10090500001)(10290500003)(2900100001)(33656002)(478600001)(9686003)(14454004)(6512007)(72206003)(6486002)(6436002)(6246003)(4326008)(53936002)(33716001)(229853002)(105586002)(5250100002)(106356001)(66066001)(6916009)(25786009)(486006)(476003)(86362001)(2906002)(81166006)(81156014)(93886005)(8676002)(186003)(5660300001)(8936002)(102836004)(86612001)(11346002)(446003)(6506007)(26005)(6346003)(14444005)(1076002)(256004)(6116002)(76176011)(3846002)(99286004)(68736007)(316002)(71200400001)(71190400001)(54906003)(22452003)(33896004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: YRlQzvJWRK/dVN836pEjBqtmJd9XGmU1a2QDNZ0Dz9FkvtzZKDu7vd2XK2B5SbHxhFYrQ7aydevfwp78HJ9i6zrKSkB1mArpUttkwz+oJ+O38HGDkGF/4folddTf+P6jPbyqLjdCS5/vVeo1U/PZ0EVi3tACyuFo6JB1du4JfVxa0AsKLQKEnCmevB1h+sQryoK+lQrvFC+0q621kN7E8GHMOs4fAbHfL5QN9NfXRAdwiuTBG6XiRpYENhfY9aPFqHYP8ZT6G1WD42l68eQBW2VFlE/UggL2vqfNBY0kvuCrqkuRPH62A/PdMuYA2yMT0/wDz/eQF5txqpe8asnJ3mnVqqpjcY8d/PMRXHgKlOU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E37A55A0015A344C8FE662C9DFB1EC18@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d6749d-ed63-4127-6806-08d6226ea568
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 22:39:53.5042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 11:03:25AM -0700, Joe Perches wrote:
>On Mon, 2018-09-24 at 19:59 +0200, Greg Kroah-Hartman wrote:
>> On Mon, Sep 24, 2018 at 09:38:26AM -0700, Joe Perches wrote:
>> > On Mon, 2018-09-24 at 13:34 +0200, Greg Kroah-Hartman wrote:
>> > > 3.18-stable review patch.  If anyone has any objections, please let =
me know.
>> >
>> > Why should this sort of change be applied to a stable release?
>>
>> Originally I was just going to drop this as it's not fixing something.
>>
>> But it might be, if that macro is used in a if() statement, or something
>> like that, it could be doing something unintended.
>
>No it couldn't.
>An empty macro is equivalent to a single statement.
>
>> So I don't feel like auditing all 500+ instances where this is used,
>> it's easier to just accept the patch.
>
>It's not a bug fix.

This question came up a few months ago. Greg suggested that we should be
pulling in warning fixes to get the stable kernels warning-free similar
to upstream.

The reasoning behind it was similar to the "no warnings" reasoning of
upstream: there might be real issues hiding in the sea of "harmless"
warnings, so we want to get rid of all of them to catch real issues.

So I was taking warning fixes even if they are of the harmless kind just
to get rid of warnings in stable branches.

--
Thanks,
Sasha=
