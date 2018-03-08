Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965415AbeCHGXx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 01:23:53 -0500
Received: from mo1502.tsb.2iij.net ([210.149.48.174]:44790 "EHLO
        mo.tsb.2iij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935418AbeCHGXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 01:23:49 -0500
X-MXL-Hash: 5aa0d6e8291b385c-fd8e47f6acc0001c2354f3cc9529c58a67d8ed82
From: <masanobu2.koike@toshiba.co.jp>
To: <penguin-kernel@I-love.SAKURA.ne.jp>, <casey@schaufler-ca.com>
CC: <jmorris@namei.org>, <serge@hallyn.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [RFC v2 1/2] WhiteEgret: Add WhiteEgret core functions.
Thread-Topic: [RFC v2 1/2] WhiteEgret: Add WhiteEgret core functions.
Thread-Index: AQHTssi2YobdO7JaGkut+ZrsdYcRG6PF4vNg
Date: Thu, 8 Mar 2018 06:23:31 +0000
Message-ID: <TYXPR01MB18549C3215C503A8E1ACE459F1DF0@TYXPR01MB1854.jpnprd01.prod.outlook.com>
References: <20180301073830.2551-1-masanobu2.koike@toshiba.co.jp>
        <458a466a-78bc-80d4-4d52-64b92d39f416@schaufler-ca.com>
        <TYXPR01MB18540A7EDCE6F5BE8CFE130EF1C50@TYXPR01MB1854.jpnprd01.prod.outlook.com>
 <201803031722.EDF21804.QHMOtFJOFFOLSV@I-love.SAKURA.ne.jp>
In-Reply-To: <201803031722.EDF21804.QHMOtFJOFFOLSV@I-love.SAKURA.ne.jp>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=masanobu2.koike@toshiba.co.jp;
x-originating-ip: [103.91.184.160]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYXPR01MB0688;7:DHeUMCkJqTBpzFETlJ3fT+3SPahqgjZczP8SnkBkUwhwlEIAtTqDXTBwvfNe4e2Y2lQlPMQh9zqieP3xrDI98tps8tEUv8DmFhbNlcazqz42xGWS60ZMh3fc6vmNFvLddo4gVcNdIi3m8yxWjKfSr0cOQODrmtiSAiawerqeiPMXN7YfIH/t1IbgATz9hlfEsPK5uk4v7Ya6WulJnEpRUFGzB3Dc0Cn5xBgOpXHVnTS4eQSp31Wp721jWwkGrfqI
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 30d83ffa-a46b-4e02-0819-08d584bd1d4e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TYXPR01MB0688;
x-ms-traffictypediagnostic: TYXPR01MB0688:
x-microsoft-antispam-prvs: <TYXPR01MB0688113FEE44E4A33303C456F1DF0@TYXPR01MB0688.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:TYXPR01MB0688;BCL:0;PCL:0;RULEID:;SRVR:TYXPR01MB0688;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39380400002)(346002)(376002)(396003)(366004)(39850400004)(189003)(199004)(59450400001)(2950100002)(102836004)(81156014)(53546011)(6506007)(229853002)(2900100001)(93886005)(110136005)(97736004)(74482002)(186003)(26005)(2501003)(3660700001)(76176011)(478600001)(316002)(8676002)(345774005)(5250100002)(74316002)(105586002)(7736002)(305945005)(68736007)(86362001)(81166006)(25786009)(6116002)(9686003)(8936002)(53936002)(3846002)(6436002)(55016002)(5660300001)(6246003)(4326008)(106356001)(14454004)(3280700002)(99286004)(54906003)(66066001)(7696005)(2906002)(33656002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:TYXPR01MB0688;H:TYXPR01MB1854.jpnprd01.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: duRwUCkYwtGBjQArQl5DZfyg0T70G4vmpqO81dwDtuWGOhG5erjI7llu+CoI3cYAF3J/VcaWAoaBe5MRRwAix+0tfth7QKlFITVE6fy3bELebZqBXEQAf9XXVOgyk3Avx5ijKFaibg6O7ehp3hRJU2C1vbWn4djEPaKNP4MIUmuJpKbGiUMm+N3cEGeX98DzP1x2v+uhFwKg+vk6eYSaSCKWDsfwJbBbFqJRbRFPHQdZx7gewAsQLQUhs7jMUFPBMnOWiXB5TTMup9FR+MmCyK3X0DwD0d5PQH+ir/WO8Q+ZnB149NbwISg0OJDSr0026MgZeAjVbTxjvZy+imgxyQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d83ffa-a46b-4e02-0819-08d584bd1d4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 06:23:31.7506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB0688
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
X-MAIL-FROM: <masanobu2.koike@toshiba.co.jp>
X-SOURCE-IP: [172.27.153.184]
X-Spam: exempt
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w286O3GY006628


On Saturday, March 03, 2018 5:22 PM, Tetsuo Handa wrote:
> Masanobu Koike wrote:
> > On Friday, March 02, 2018 12:43 AM, Casey Schaufler wrote:
> > > On 2/28/2018 11:38 PM, Masanobu Koike wrote:
> > > > @@ -264,6 +266,9 @@ choice
> > > >  	config DEFAULT_SECURITY_APPARMOR
> > > >  		bool "AppArmor" if SECURITY_APPARMOR=y
> > > >
> > > > +	config DEFAULT_SECURITY_WHITEEGRET
> > > > +		bool "WhiteEgret" if SECURITY_WHITEEGRET=y
> > > > +
> > >
> > > I don't see this module using any security blobs. Is there
> > > a reason you're not making this a minor (like yama) module
> > > instead of a major (like AppArmor) module?
> >
> > Thank you for your suggestion.
> > We are now developing WhiteEgret on the environment
> > it works certainly.
> >
> 
> ??? What Casey suggested is effectively
> 
> ----------
> --- a/security/whiteegret/init.c
> +++ b/security/whiteegret/init.c
> @@ -48,9 +48,6 @@ static int __init we_init(void)
>  {
>  	int rc;
> 
> -	if (!security_module_enable("whiteegret"))
> -		return 0;
> -
>  	security_add_hooks(we_hooks, ARRAY_SIZE(we_hooks),
> "whiteegret");
> 
>  	rc = we_specific_init();
> ----------
> 
> , isn't it? Unlike Yama, adding whiteegret_add_hooks() to security_init()
> is not useful, for security_init() is called too early to create securityfs
> entries for WhiteEgret.
> 
> Current version uses security= parameter as a switch for enabling/disabling
> WhiteEgret, doesn't it? If WhiteEgret does not use security= as a switch,
> is some other switch (e.g. __setup()) expected?

Sorry for the delay.
Thank you for your comment and suggestion.
I'll make this module a minor one in the
next version.

Masanobu Koike
