Return-Path: <laurentiu.tudor@nxp.com>
X-Google-Smtp-Source: AIpwx4948HoYLrKot1/aWkSJ/aYQgoT216llqpODeiemGv9fitxwQl0feZm1k3RqrzNcbKRiNRnM
ARC-Seal: i=1; a=rsa-sha256; t=1522924205; cv=none;
        d=google.com; s=arc-20160816;
        b=fDt5VwbyxedoheacnWtdbocvCZ9nf3nw5tWFGrqtwIr4V8X+bxuMgMVaNITXLzM6qK
         1DUA9mgk5NjTtyZo/Hy2o3CmS69TzfUmK94GaWnZ7bOE7X7nrPONHnR6qnd77nTATEPf
         Xlqn3WOu6TadiGA4lyplc5W9MUfraeJF5PePmntvR7FjZ4WUv0OIC/KpoBECC1t+Qnxv
         QUtiba3qHSD633jMy5nu/IrLTa0xWloTizTx1xY5EG3sceG59YupWzagMxpl0g4XOYd8
         0Nw2AlBUqpvFThZCo9c5+5fF3AKuwXsVbMm8tEnknWrjHep60kkdNT/jKRK1PsXtSPqo
         GtzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=LQTHk+mKy3rIXvfmCR5+Ecez5ztCKJhMc/DradGvRzk=;
        b=eFv2zGY8+xkw7jyy4GijiklLwNj5bxd4lFGwOX2rQZvLqCFwerMR9AqVlIb9JpsMrY
         0t8kpZ1TNGYXjF4A/daPXloimL14CKx31FyIAPeI3ADxkMn8gfEsQbN9kt+S7KrgdevL
         XG1XPQHfsSRbppZPDf1nl0CGXmisPRvzlSZ04NyUeHXHAf3q97VHp6Ch+wDqsG80FyDA
         1LPccAClJvCU9bSa2kF5xLkQczLeM5K66PuNPrfVY4lsnmM9YZB3npv86SezP1RjYJX6
         TeKEgn4V+N+oeEJhI4YJSGHQx+EnXkgqCOdIbb1aePNobx77hl9QoV+NERsCPuSz2m3r
         cjYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=Vpp/Ln0w;
       spf=pass (google.com: domain of laurentiu.tudor@nxp.com designates 40.107.5.82 as permitted sender) smtp.mailfrom=laurentiu.tudor@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=Vpp/Ln0w;
       spf=pass (google.com: domain of laurentiu.tudor@nxp.com designates 40.107.5.82 as permitted sender) smtp.mailfrom=laurentiu.tudor@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>, Stuart Yoder <stuyoder@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>, Ioana Ciornei <ioana.ciornei@nxp.com>,
	gregkh <gregkh@linuxfoundation.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Ruxandra Ioana Ciocoi Radulescu
	<ruxandra.radulescu@nxp.com>, Razvan Stefanescu <razvan.stefanescu@nxp.com>,
	Roy Pledge <roy.pledge@nxp.com>, Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Thread-Topic: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Thread-Index: AQHTwr0s//RURDTyGEKsLhU+ZuPm16PfBFwAgAa39ICAABVLAIAJ+AgAgAATBYCAACYwgIAAnIoAgAFtPQA=
Date: Thu, 5 Apr 2018 10:30:01 +0000
Message-ID: <5AC5FAA8.80409@nxp.com>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
 <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
 <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com>
 <HE1PR04MB32126A07A4B4CC7225E661E4E0A30@HE1PR04MB3212.eurprd04.prod.outlook.com>
 <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
 <CAEac7tZ4we46EEa2DuAbmMr+hW6Q4BoBKJFFf1k_k57r2oJpng@mail.gmail.com>
 <20180404010549.GA12443@lunn.ch>
 <CAEac7tYSAmgt-kAcLNToKdrBOZhvq4Q+HxYEG+NkGZAk6kDADw@mail.gmail.com>
 <20180404124246.GA20869@lunn.ch>
In-Reply-To: <20180404124246.GA20869@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0401MB1966;7:QMkarGjEVql/UOqrGQfSpzlFaW7kkz4lMcGJY9+gEr8EnZfTCHXZ6y1dRoQQzsaqmmYYBObYWpoHXMTm845k+9eVY5yZDDxUzynPkbSVGZZySIJrqq9zlnMwBXHrEpQ2zCvZIqZqoWsHTw0IllaNG2OTgGq81ozjDNf0GwFJhLnCBZfBX4g39jwbHAgv0iaH5tNUiixlfYpFmQs35PO3iVJ4ymcQ7cTpKoH/oPOmtF+G2mYsYQKiE47kBMasHA/e
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 792399b3-c992-40f1-e947-08d59ae03057
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB1966;
x-ms-traffictypediagnostic: VI1PR0401MB1966:
x-microsoft-antispam-prvs: <VI1PR0401MB196607D512ACE3B387243453ECBB0@VI1PR0401MB1966.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(6055026)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR0401MB1966;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB1966;
x-forefront-prvs: 06339BAE63
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(346002)(366004)(39380400002)(396003)(376002)(189003)(199004)(51444003)(65816011)(105586002)(6506007)(53546011)(486006)(3280700002)(106356001)(3660700001)(2906002)(81156014)(81166006)(68736007)(93886005)(478600001)(8676002)(4326008)(229853002)(186003)(102836004)(33656002)(110136005)(54906003)(316002)(25786009)(2616005)(476003)(66066001)(39060400002)(14454004)(5660300001)(26005)(446003)(6436002)(8936002)(11346002)(6486002)(2900100001)(36756003)(7736002)(6116002)(305945005)(76176011)(3846002)(97736004)(5250100002)(99286004)(86362001)(6246003)(53936002)(6512007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB1966;H:VI1PR0401MB1856.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: hDzzErbE1siBO7OHV0OFEVLYNOePR3kwMTRQj+BqLvigbndXfxXpkc54TV+ZZXIfkzel15wGQ72NjJvv0yGbyBOO/7eGWsVwlwAIrFsObokxK1sQm7emy1nWShGSaOEO0hYiERIfpk82/RGqhal0/ADDV4G97h/n29IJbyri4S73O9yoytkbDoahfLqX1SZE2juzKTeVExJguPrQ1yyFE6QFt499Gp46bSdMHThFWLDulXN5cFN/JuuMDGAHLEQ8Abf2vvFrmjgOcWPmGOlyu12e6GDNSnjeUdcZSbvyPR6632lJxX9UwimcShR5n6yI3o3pC3GsbhPhfmLRrAe5TMR5Wf5YLpNPJr6NNntSU/ekzm7ME0BAdQkM7RcRLq9n0mEronuRsw2pHtCt9IcWfw99bK4NzA22nL/GXRUxIKI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <054F1A7236CE4F4C83F69E638384D11A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792399b3-c992-40f1-e947-08d59ae03057
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2018 10:30:01.5650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB1966
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1596901770962395808?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

My 2c below.

On 04/04/2018 03:42 PM, Andrew Lunn wrote:
>> I hear you.  It is more complicated this way...having all these individu=
al
>> objects vs just a single "bundle" of them that represents a NIC.  But, t=
hat's
>> the way the DPAA2 hardware is, and we're implementing kernel support for
>> the hardware as it is.
>
> Hi Stuart
>
> I see we are not making any progress here.
>
> So what i suggest is you post the kernel code and configuration tool
> concept to netdev for a full review. You want reviews from David
> Miller, Jiri Pirko, Jakub Kicinski, David Ahern, etc.
>

I think that the discussion steered too much towards networking related=20
topics, while this ioctl doesn't have much to do with networking.
It's just an ioctl for our mc-bus bus driver that is used to manage the=20
devices on this bus through userspace tools.
In addition, I'd drop any mention of our reference user space app=20
(restool) to emphasize that this ioctl is not added just for a=20
particular user space app. I think Stuart also mentioned this.

---
Thanks & Best Regards, Laurentiu
