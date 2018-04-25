Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756107AbeDYRoY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:44:24 -0400
Received: from mail-by2nam01on0102.outbound.protection.outlook.com ([104.47.34.102]:52497
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756048AbeDYRnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:43:55 -0400
From: Trent Piepho <tpiepho@impinj.com>
To: "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>
CC: "hch@infradead.org" <hch@infradead.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "arvind.yadav.cs@gmail.com" <arvind.yadav.cs@gmail.com>,
        "mjpeg-users@lists.sourceforge.net"
        <mjpeg-users@lists.sourceforge.net>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "hans.verkuil@cisco.com" <hans.verkuil@cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: zoran: move to dma-mapping interface
Thread-Topic: [PATCH] media: zoran: move to dma-mapping interface
Thread-Index: AQHT3K4/9r2Qrf151EmnPiT9nCt7VaQRupyAgAAF+4A=
Date: Wed, 25 Apr 2018 17:43:53 +0000
Message-ID: <1524678233.31312.5.camel@impinj.com>
References: <20180424204158.2764095-1-arnd@arndb.de>
         <20180425061537.GA23383@infradead.org>
         <CAK8P3a06ragAPWpHGm-bGoZ8t6QyAttWJfD0jU_wcGy7FqLb5w@mail.gmail.com>
         <20180425072138.GA16375@infradead.org>
         <CAK8P3a1cs_SPesadAQhV3QU97WjNE8bLPSQCfaMQRU7zr_oh3w@mail.gmail.com>
         <20180425152636.GC27076@infradead.org>
         <CAK8P3a0CHSC7yP3x8xDJgcg5xMzD1-sC-rmBJECtYvGFmyG4vQ@mail.gmail.com>
         <20180425142229.25d756ed@vento.lan>
In-Reply-To: <20180425142229.25d756ed@vento.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com;
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3706;7:KWP/1Lrc/9j1/M/t1Ty5/kdkWHVCOnelHk6W5qWQfqjVFDNeKRH39DgTY1BOCaq5o89ofjW42ixTASODylY4+DX1+PpR4a2QdEfEUCHV0WNLxab84alg0vI4wC7wppTkWNLZghgmQHdAjeviWz+mLHu/Wu+B9RzHnjOvOjycYTURYON+EsFV6DakYfJD3PSScokO89tloeZ0eulb+JBybjObqUj2sZRKk6QatazArbc/Jn79ePOc4aUHI3y+Weub
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3706;
x-ms-traffictypediagnostic: MWHPR0601MB3706:
x-microsoft-antispam-prvs: <MWHPR0601MB3706671B1247A330574A167ED38F0@MWHPR0601MB3706.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR0601MB3706;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3706;
x-forefront-prvs: 06530126A4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(366004)(396003)(39380400002)(376002)(51444003)(189003)(377424004)(52314003)(199004)(93886005)(476003)(99286004)(8676002)(486006)(86362001)(76176011)(53936002)(102836004)(6506007)(8936002)(7736002)(53546011)(25786009)(446003)(11346002)(5660300001)(39060400002)(54906003)(81156014)(26005)(6512007)(2900100001)(6246003)(478600001)(66066001)(316002)(110136005)(81166006)(6486002)(4326008)(105586002)(229853002)(97736004)(68736007)(305945005)(106356001)(3660700001)(2616005)(3280700002)(2501003)(103116003)(14454004)(5250100002)(3846002)(36756003)(186003)(6436002)(6116002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3706;H:MWHPR0601MB3753.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: lggc5eNJELmn2KxUGNKmcwzIKAPkEzJjO+EItbi1jB4qUwD2KclfzN9p1az/4+sf4xG8lJfyYymuVPbqCGtruBULpAjKjNJP3nDcLV3shCXzFmGF0cXHXmKDjjuQ+nRfwRxGH1cOBxmptF1LUsqBznKcb0mjQ3vR6UHNHz9q2o9lZNtxxjBDV35w5SmrAdji
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9FF15A57AA26B49B71F9C46AE3F6C5F@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c6e84c87-97f3-412e-5cb5-08d5aad41d01
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e84c87-97f3-412e-5cb5-08d5aad41d01
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2018 17:43:53.8741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3706
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3PHiVX9015671

On Wed, 2018-04-25 at 14:22 -0300, Mauro Carvalho Chehab wrote:
> Em Wed, 25 Apr 2018 17:58:25 +0200
> Arnd Bergmann <arnd@arndb.de> escreveu:
> 
> > On Wed, Apr 25, 2018 at 5:26 PM, Christoph Hellwig <hch@infradead.o
> > rg> wrote:
> > > On Wed, Apr 25, 2018 at 01:15:18PM +0200, Arnd Bergmann wrote:  
> > > > That thought had occurred to me as well. I removed the oldest ISDN
> > > > drivers already some years ago, and the OSS sound drivers
> > > > got removed as well, and comedi got converted to the dma-mapping
> > > > interfaces, so there isn't much left at all now. This is what we
> > > > have as of v4.17-rc1:  
> > > 
> > > Yes, I've been looking at various grotty old bits to purge.  Usually
> > > I've been looking for some non-tree wide patches and CCed the last
> > > active people to see if they care.  In a few cases people do, but
> > > most often no one does.  
> > 
> > Let's start with this one (zoran) then, as Mauro is keen on having
> > all media drivers compile-testable on x86-64 and arm.
> > 
> > Trent Piepho and Hans Verkuil both worked on this driver in the
> > 2008/2009 timeframe and those were the last commits from anyone
> > who appears to have tested their patches on actual hardware.
> 
> Zoran is a driver for old hardware. I don't doubt that are people
> out there still using it, but who knows?
> 
> I have a few those boards packed somewhere. I haven't work with PCI
> hardware for a while. If needed, I can try to seek for them and
> do some tests. I need first to unpack a machine with PCI slots...
> the NUCs I generally use for development don't have any :-)
> 
> Anyway, except for virt_to_bus() and related stuff, I think that this
> driver is in good shape, as Hans did a lot of work in the past to
> make it to use the current media framework.

I still have a zoran board.  And my recently purchased ryzen system has
PCI slots.  To my surprise they are not uncommon on new socket AM4
boards.  However, I think the zoran board I have is 5V PCI and that is
rather uncommon.  Also becoming uncommon is analog NTSC/PAL video that
this chip is designed for!

If anyone is using these still, they would be in legacy systems for
these legacy video formats.
