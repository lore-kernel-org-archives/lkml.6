Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeCaFL3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 01:11:29 -0400
Received: from mail-eopbgr00138.outbound.protection.outlook.com ([40.107.0.138]:7747
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750798AbeCaFL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 01:11:27 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com;
Date: Fri, 30 Mar 2018 22:11:09 -0700
From: Andrei Vagin <avagin@virtuozzo.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [03/10] genksyms: generate lexer and parser during build instead
 of shipping
Message-ID: <20180331051107.GA23033@outlook.office365.com>
References: <1521810279-6282-3-git-send-email-yamada.masahiro@socionext.com>
 <20180330174022.GA8890@outlook.office365.com>
 <20180330222145.GC20025@outlook.office365.com>
 <CAK7LNARab5mN0F4OrW03v=EsmaRiutLxqR6J1vkybVW=gMvzqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <CAK7LNARab5mN0F4OrW03v=EsmaRiutLxqR6J1vkybVW=gMvzqw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [73.140.212.29]
X-ClientProxiedBy: MWHPR12CA0050.namprd12.prod.outlook.com
 (2603:10b6:300:103::12) To AM4PR08MB0740.eurprd08.prod.outlook.com
 (2a01:111:e400:59ed::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1ab9dbe-7895-4724-d12b-08d596c5d911
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR08MB0740;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB0740;3:OlHB6sPFvv/8ARLgj5N5Dz3pHdDzy4b/ZxC8Q5Gc1PM1C3rqBSK/dSKUTDh+ZKji6HeU7XHLf0KNCVWJAeVnbtgtsmGZWvgDS2s//FPohRw2SGKn0aoEiKDtBNCMnS1k43xKwtssKgoY14Kgg33F9l73NFyZXQKjbqoyX58quQB8nU2X1b5CiId81s+GYUTUUYzGsZwAeAvwIBAq3Uf30WHeegEBrE7mCGRgRzNx0jbGKWNkeG5x5JOhTE8JBShs;25:Z/SyJ3ap57C3dZn1vSBMNeapgMQn/+8SdFb9YAYT89pVhUCwffGhSzdoHEBRT+KsNhhodA2RQvXmdwWGWsljKARNRlhbGt1FsHnlxkBkrSEnuQWd1m4UujEwRKdC3jgvea4u+G1I7D1JgC2kqwn2FO9P6eRNScKTg+OqImOYbCrj02RRFvmAlvCaCN/au9gDSpgmg8zGlMfoUcOqliWHexxJQCAZb9BQH+UuTfS56A2xQWVszpHk2F9sNa0mrzhlT9tmjNL6RO/SS1HZXgR94V28yItbzGMOOzjHHCowF2XfwXaatGWrEypPcj1ZzmL204YhvyiQRWbeNyrgt41khw==;31:dwHifDBh0g6RTOndgbomyNk8mF9r7IcRbwjm0giGLUFtKvohqyfL394tQfTBNBan91i3xZPlkLYopCDzUGhKFIOsvkjKhktif/PNR6xMyQRKib/QM1MlB/BauzSmj6mnTgehP22ZpCXuAU4XP5pEXsLWxPXZ0bXIT1r2HccNxtDnIfnFCvOocP+xR+urYvb8FpT8P5sG9mHk/P70OXIB6aWiHezbPrrmW0uIRiNGoRM=
X-MS-TrafficTypeDiagnostic: AM4PR08MB0740:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB0740;20:SDaNZhhYyZhAqFn7khuOIjOSJmSQZZToPPIfrGcL/4+BxZeyCGZTBRThTpRuR+JsJ+M/GuIAVc+8PQq2WTCo7XUITgXklNNjMGbUWVppFiD1e4FD59heA2/3ViJS5TKlF8PG+j37n+L9TpAjQlIza56/csQYEiCoeIbQfiiNJK096pKjya34nxu1ktCyRg9VyjIoxQNb3VsV4NIngO4o5lDfnh8nmwaUirTZ4fZu6Q6WlE26bjPWIy3X4amr+hx573Y9ZzGUSQ+Ag544ur3KWO8xOYdWDT1kU/VXOoEdhKHdbMSCpR4BuSnTXMEiSwGXNYkmVyTCZInnK6r7ig41i0RCXGexgnUspLRVeVaeclbAHp1Dp+B9GHG5pjxQ2UqslMpVUlcDIeGVO3PBnGfTeTIFtCJDC+wD/P4GY70fvOHoW+yJWsFljal6FeQNfnYtHlVAU8Vza4DRa3VxnAV3b2ksHMw3IUtUVjY//6hLAxN/QQ1xlvXy2SWkJW7zsmng;4:aaW0YErQ0qubKvDqoQGslghmo2L1WlMYnl9XFjmc0Gg+fbxa96oKVU4CJBiBFhSsNNVcHmCTKALRjAqKM4Of34g7Vzj6vyM0FKlhzby28ExOW9C7CI3OFeEcXy9nnaftVXvbvOTrXuZg3Dr93IPjwPZ7THJefxZ/R+Y0ZKCT1GUzc8mNZGdU/1BJRXRJMVMYggN5xSedi+mG7Zw2Yk5x9g4yDGTyuktje7oVD3pR0VzudLQeb4bpXIGeERmaNm2eQompFWjiFmzqVvIDg8Wj3CF1a81zV2s1LMia9duWIOmRdX5/y9HRegXIetWrtQ1f
X-Microsoft-Antispam-PRVS: <AM4PR08MB07402E183476E59075036BDBCFA00@AM4PR08MB0740.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(251416522907027);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR08MB0740;BCL:0;PCL:0;RULEID:;SRVR:AM4PR08MB0740;
X-Forefront-PRVS: 062899525A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39850400004)(39380400002)(346002)(376002)(377424004)(199004)(189003)(51914003)(26005)(6306002)(16526019)(68736007)(9686003)(55016002)(186003)(11346002)(23686003)(53936002)(446003)(5890100001)(478600001)(58126008)(47776003)(66066001)(956004)(5660300001)(16586007)(25786009)(229853002)(486005)(486005)(1076002)(106356001)(6506007)(6246003)(54906003)(50466002)(386003)(4326008)(476003)(3846002)(7736002)(6916009)(6666003)(53416004)(69596002)(966005)(59450400001)(2906002)(105586002)(8936002)(81166006)(81156014)(52116002)(97736004)(7696005)(305945005)(8656006)(8676002)(76176011)(86362001)(93886005)(316002)(33656002)(6116002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR08MB0740;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;AM4PR08MB0740;23:VYUc1U6gkk/bHvh4Ep2+w7R/m/NMJs1q3BwESlWRwC6?=
 =?koi8-r?Q?BnHQSGW/8wwvmkxmQxdpekSUWla5KBlH2yM97//MnBDSh1dDmkKMZ7xX/p49k0?=
 =?koi8-r?Q?uOBx4em/1xcbfFiuX4Q5A6annL6qYg8sze91Z4pp7rvpD7GavVK24jcXWjuNtG?=
 =?koi8-r?Q?Ep5n0wuDc31q7xZqv4WDLgtYkDm1/pGj8s2VeN5stLgQrjdMxPQfYUb3tDx7G2?=
 =?koi8-r?Q?FGkxS0ZWtGdY8xh1F5QxaUJYOmD7XXz2r1KtahVqDenMPVjbLLqUTtaQcdF3QM?=
 =?koi8-r?Q?CxltkUfkFgTldyruHnw91JFjj4aFTo1yc6KID/1G/fTpcIhzJHUmOIaiM8z3OC?=
 =?koi8-r?Q?cDek+aUBAeukwon7f3ZzkUUUYv4v67sLAzSKwY7QBIXj32/VBnf21DnCd8n7bq?=
 =?koi8-r?Q?r3N7zdTq7agN054CrjSDZGR246cc5wgXEuqClSYLCgqHmZzbyafN95AfPrJnvA?=
 =?koi8-r?Q?u59uJzym2W3+zLw0EwPzqSsuarUmyoh6EF82jOE8sUeSHcjLYLeHsgqt2sUZfH?=
 =?koi8-r?Q?FLU9yUz9wdhOklwkmQrjsMoKRkv43BcWJ43gWJVpI23E2vsY0sNYg+ggnPpGcf?=
 =?koi8-r?Q?L90SLLjb4bGaD5f1WUAc9KcktSOwVMWA4ZarIapukLlmVEwgdxhuu0NmwWX2Ve?=
 =?koi8-r?Q?JWmcslsAVRA7S0RW88OwO1HCXlAVboYFULw/vqe2HObkR1oBhbSilPTGUJzzoR?=
 =?koi8-r?Q?CluUKRJ79kFtBJTYWC3OgQL2T5/xuOYpDBVvRrRKGkIrIJKj/xY+WetGkS4GLf?=
 =?koi8-r?Q?hQFycKbVbj+ieAqbr6S/ShAaNnRoTuEflW0rmJCVPDjawXRSw7QYFypPprL0Cz?=
 =?koi8-r?Q?Osflfqc3gffzXOtSRSNgqKkpbwhiMNVMNraNcI07TM8fpBsIZSIiTfp+W3isCs?=
 =?koi8-r?Q?PviXvLEOVBMyk9uLXjJOKPZLiz5plh1NkPjcgpiP4cKXM2N+RGfeKWSXF0QuZX?=
 =?koi8-r?Q?Qoz7Tec7kSIsd3WvCs0bAAeuH535axXLhfB3wmmSMRE2uZTX/uIjbxf4j8xbGE?=
 =?koi8-r?Q?sHU4jVPhP7WIURuNMkdtWGxqfVUzl7KUqSdDdFj2HdFNXgWIvDLKN7gDZ4EcWE?=
 =?koi8-r?Q?tbyZFlTSqsacsZO6DMVtRs3gAHjzDUifosnvVrwTASCuuicnRY8mFAzt7oNmU4?=
 =?koi8-r?Q?KyDTW02gD7vjW1nycJ1hWIvQPJdKixAnbOUbaqm2rAAiEkKo9Vh4W2sy14Fhfg?=
 =?koi8-r?Q?6SmlHRr77/+BFrCxU6vX+99u6SLEk99mJ5OvTUPVLV0Y8G+1Cy7/fgH8LWlAV4?=
 =?koi8-r?Q?f1Gtdlg1Klyfu8OqqI9q+/iBzSgAo7QTtuew393OEBQxN97P3PYrcPkGRHAdst?=
 =?koi8-r?Q?4yiM/slzJ7eNYb0eU+NWEmoUFv2jbWf5HKZgZx+m07fT7xLWXnwZszkw6eiVaL?=
 =?koi8-r?Q?Ljfv+mK75giN3r1KUo/i9GPC9miAEPJMFCLXQxYElw94Lnp+9ye/Dm1IWpQ17O?=
 =?koi8-r?Q?kplkB0QC5+l2rZRCPuflMnUflJ4zVGv6sKJyvjGq6enVAk=3D?=
X-Microsoft-Antispam-Message-Info: BzjeVXKGHq0sk9WVTHnns1nQMrgfzVBZ9vVGUjHNc/i5+WMci3VRxkWwhZsq20aU9BHNrDMJazXlYpzy/8HWkGdXT6ro1YyVTSD43fL5tjzGGUQd7SU+ZGFxDGSvCJat0o1vQoTS3h+4p1J966vEBJtew6irusWdTD29X3uXFyxjS2y7SFvK/GSH+QIYveYK
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB0740;6:UGo/LSRJe9C3CFE6yqSfz94W7n6s7HJiHIZ1R11C4QxlpFNzwKnJu7WGXrg6xot5RKYngEFPoWezNhtC7XIM5CEvmGm0PFrGXjAE8bIPVGcK1+a3QoV8T2wP9eUyT5SJpwSz3UPE7ZCE8XK1En6Bul1/UEIquqRTuTsvrWB42Qs8PJZZ96o+27h91GcV2vt9SAYD/Bd0c0f6r/pTqxR3vdwfgHg2DgjczR4e0c4KAHijpzKQ25V/JA7kw3ooLsOA1HDdHnT/L99YYwtudtoxptdHHTFJOjvCUrjrvqzt7iwR1FfZsskX4Sto9D8OH7QMGyTMcWCQkbYr9MpE4PP9lNfxtYfu9/ewEperQoJcpEWOe8xrAaYSijUVoNy0AIFyI1GwNPpOgFwZjJDs2PNzwfUuTayI2yhO9NTwHp0/U539kBuJr4+NvOd7K3YMNzVv2vczxzbizX6oEKECAM9hDQ==;5:kKUnyGSp0I1wX+/8WXhpPuWk8orsTwAcKayHS6AXl+9lp1Yu8jP5zAXgGd3RMEmO1sLiXWG169oBMWdWVhR4U477KMNkHdxoLZc5zd9VjGfarq33V7vZFkn2Qiaf0Q6HETYMH066dxO7PuY3u3NjtiCcNHykm5/hVUsw/MKy73E=;24:VQWPSEehSGoH6GHm7kVwkugmWoFocJ7NmV2D40p0ntAyutipTuaDCT+4BZrSTsH9tWTtlqPuxqr2PQQcPNZNnyibYYvjWxkaaVts0I+DItY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB0740;7:yDpjHLksFOJg7cdT759NT1RURG8cylAaoNeZVZ7uMdWKAheD83aczLtiPzQBsGDY9O7+SlO/LAWXel8iE+348alykdoLeJ/SK8m7lCVjp9TSRxnzj7U/QpG+tK3nLLWLLssVKjzHmkDf9PwdLjgnjwpBJbYgGVf4oVTN/yCDeNec5MgohNTCm1bLajS16+DztPja23YGBWEkn13+5tz+//mebs55RWKvlE2/TMmnWzf39ibDnxBvrU4SNXdyNTqD;20:6Fx81a0gu7Jl7YnrBIgWS9EIQbFlWZhoOkuBJomk9BeXrEuWD5Qc8JtYobsPTpZgfm9JB+VAstVp5c4CkRkpNC+4uwVQr6QJhWpezNGzzRX3+9WHx9a6/lSXLAod2p8mpBboygfXjFFYbjPSp8FuGe9IlKDCgiL5pElWamYpSuI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2018 05:11:20.8857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ab9dbe-7895-4724-d12b-08d596c5d911
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB0740
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2018 at 11:20:22AM +0900, Masahiro Yamada wrote:
> 2018-03-31 7:21 GMT+09:00 Andrei Vagin <avagin@virtuozzo.com>:
> > On Fri, Mar 30, 2018 at 10:40:22AM -0700, Andrei Vagin wrote:
> >> On Fri, Mar 23, 2018 at 10:04:32PM +0900, Masahiro Yamada wrote:
> >> > Now that the kernel build supports flex and bison, remove the _shipped
> >> > files and generate them during the build instead.
> >> >
> >> > There are no more shipped lexer and parser, so I ripped off the rules
> >> > in scripts/Malefile.lib that were used for REGENERATE_PARSERS.
> >> >
> >> > The genksyms parser has ambiguous grammar, which would emit warnings:
> >> >
> >> >  scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
> >> >  scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
> >> >
> >> > They are normally suppressed, but displayed when W=1 is given.
> >> >
> >> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >> > ---
> >> >
> >> >  scripts/Makefile.lib                 |   24 +-
> >> >  scripts/genksyms/Makefile            |   23 +
> >> >  scripts/genksyms/lex.lex.c_shipped   | 2291 --------------------------------
> >> >  scripts/genksyms/parse.tab.c_shipped | 2394 ----------------------------------
> >> >  scripts/genksyms/parse.tab.h_shipped |  119 --
> >> >  5 files changed, 26 insertions(+), 4825 deletions(-)
> >> >  delete mode 100644 scripts/genksyms/lex.lex.c_shipped
> >> >  delete mode 100644 scripts/genksyms/parse.tab.c_shipped
> >> >  delete mode 100644 scripts/genksyms/parse.tab.h_shipped
> >> >
> >> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> >> > index 2fde810..b7d2c97 100644
> >> > --- a/scripts/Makefile.lib
> >> > +++ b/scripts/Makefile.lib
> >> > @@ -183,14 +183,8 @@ endef
> >> >  quiet_cmd_flex = LEX     $@
> >> >        cmd_flex = $(LEX) -o$@ -L $<
> >> >
> >> > -ifdef REGENERATE_PARSERS
> >> > -.PRECIOUS: $(src)/%.lex.c_shipped
> >> > -$(src)/%.lex.c_shipped: $(src)/%.l
> >> > -   $(call cmd,flex)
> >> > -endif
> >> > -
> >> >  .PRECIOUS: $(obj)/%.lex.c
> >> > -$(filter %.lex.c,$(targets)): $(obj)/%.lex.c: $(src)/%.l FORCE
> >> > +$(obj)/%.lex.c: $(src)/%.l FORCE
> >> >     $(call if_changed,flex)
> >> >
> >> >  # YACC
> >> > @@ -198,27 +192,15 @@ $(filter %.lex.c,$(targets)): $(obj)/%.lex.c: $(src)/%.l FORCE
> >> >  quiet_cmd_bison = YACC    $@
> >> >        cmd_bison = $(YACC) -o$@ -t -l $<
> >> >
> >> > -ifdef REGENERATE_PARSERS
> >> > -.PRECIOUS: $(src)/%.tab.c_shipped
> >> > -$(src)/%.tab.c_shipped: $(src)/%.y
> >> > -   $(call cmd,bison)
> >> > -endif
> >> > -
> >> >  .PRECIOUS: $(obj)/%.tab.c
> >> > -$(filter %.tab.c,$(targets)): $(obj)/%.tab.c: $(src)/%.y FORCE
> >> > +$(obj)/%.tab.c: $(src)/%.y FORCE
> >> >     $(call if_changed,bison)
> >> >
> >> >  quiet_cmd_bison_h = YACC    $@
> >> >        cmd_bison_h = bison -o/dev/null --defines=$@ -t -l $<
> >> >
> >> > -ifdef REGENERATE_PARSERS
> >> > -.PRECIOUS: $(src)/%.tab.h_shipped
> >> > -$(src)/%.tab.h_shipped: $(src)/%.y
> >> > -   $(call cmd,bison_h)
> >> > -endif
> >> > -
> >> >  .PRECIOUS: $(obj)/%.tab.h
> >> > -$(filter %.tab.h,$(targets)): $(obj)/%.tab.h: $(src)/%.y FORCE
> >> > +$(obj)/%.tab.h: $(src)/%.y FORCE
> >> >     $(call if_changed,bison_h)
> >> >
> >> >  # Shipped files
> >> > diff --git a/scripts/genksyms/Makefile b/scripts/genksyms/Makefile
> >> > index 0ccac51..f4749e8 100644
> >> > --- a/scripts/genksyms/Makefile
> >> > +++ b/scripts/genksyms/Makefile
> >> > @@ -5,9 +5,32 @@ always             := $(hostprogs-y)
> >> >
> >> >  genksyms-objs      := genksyms.o parse.tab.o lex.lex.o
> >> >
> >> > +# FIXME: fix the ambiguous grammar in parse.y and delete this hack
> >> > +#
> >> > +# Suppress shift/reduce, reduce/reduce conflicts warnings
> >> > +# unless W=1 is specified.
> >> > +ifeq ($(findstring 1,$(KBUILD_ENABLE_EXTRA_GCC_CHECKS)),)
> >> > +SUPPRESS_BISON_WARNING := 2>/dev/null
> >>
> >> We have a robot which runs CRIU tests on linux-next.
> >> Yesterday it failed with this error:
> >>
> >>   HOSTCC  scripts/genksyms/genksyms.o
> >> make[2]: *** [scripts/genksyms/parse.tab.c] Error 127
> >>
> >> cripts/genksyms/Makefile:20: recipe for target 'scripts/genksyms/parse.tab.c' failed
> >> scripts/Makefile.build:559: recipe for target 'scripts/genksyms' failed
> >> Makefile:1073: recipe for target 'scripts' failed
> >> make[1]: *** [scripts/genksyms] Error 2
> >> make: *** [scripts] Error 2
> >> make: *** Waiting for unfinished jobs....
> >>
> >> https://travis-ci.org/avagin/linux/jobs/360056903
> >>
> >> From this output, it is very hard to understand what was going wrong.
> >
> >
> > The reason was that bison and fles were not installed, but I think the
> > error message should be more clear.
> >
> >>
> >> Thanks,
> >> Andrei
> >>
> 
> Thanks for the report.
> 
> 
> OK, I will apply the fix-up attached below.
> 
> If bison is not installed, it will fail with clear message.

Thank you!

> 
>   HOSTCC  scripts/genksyms/genksyms.o
> /bin/sh: 1: bison: not found
> make[2]: *** [scripts/genksyms/Makefile:18:
> scripts/genksyms/parse.tab.c] Error 127
> make[1]: *** [scripts/Makefile.build:559: scripts/genksyms] Error 2
> make: *** [Makefile:1073: scripts] Error 2
> 
> 
> BTW, without flex and bison, how did you build Kconfig?

A config is created on the host, but a kernel is compiled in a docker
container. Maybe bison was installed on the host.

We do something like this:

$ make olddefconfig
$ make localyesconfig
$ docker run -v /home/travis/build/avagin/linux:/mnt/kernel -v
/home/travis/.ccache:/mnt/ccache -w /mnt/kernel criu-kernel make -j 4

> 
> Since commit 29c833061c1d8c2d1d23a62e7061561eadd76cdb,
> Kconfig requires flex and bison, and this commit is
> in Linus' tree for a couple of month.
> 
> Without flex and bison, you cannot do even "make *config"
> Nobody has ever complaint about this.
> 
> 
> 
> 
> diff --git a/scripts/genksyms/Makefile b/scripts/genksyms/Makefile
> index aeefd47..7cb3d70 100644
> --- a/scripts/genksyms/Makefile
> +++ b/scripts/genksyms/Makefile
> @@ -10,20 +10,20 @@ genksyms-objs       := genksyms.o parse.tab.o lex.lex.o
>  # Suppress shift/reduce, reduce/reduce conflicts warnings
>  # unless W=1 is specified.
>  ifeq ($(findstring 1,$(KBUILD_ENABLE_EXTRA_GCC_CHECKS)),)
> -SUPPRESS_BISON_WARNING := 2>/dev/null
> -endif
> 
>  quiet_cmd_bison_no_warn = $(quet_cmd_bison)
> -      cmd_bison_no_warn = $(cmd_bison) $(SUPPRESS_BISON_WARNING)
> +      cmd_bison_no_warn = $(YACC) --version >/dev/null; $(cmd_bison)
> 2>/dev/null
> 
>  $(obj)/parse.tab.c: $(src)/parse.y FORCE
>         $(call if_changed,bison_no_warn)
> 
>  quiet_cmd_bison_h_no_warn = $(quet_cmd_bison_h)
> -      cmd_bison_h_no_warn = $(cmd_bison_h) $(SUPPRESS_BISON_WARNING)
> +      cmd_bison_h_no_warn = $(YACC) --version >/dev/null;
> $(cmd_bison_h) 2>/dev/null
> 
>  $(obj)/parse.tab.h: $(src)/parse.y FORCE
>         $(call if_changed,bison_h_no_warn)
> +
> +endif
>  # FIXME END
> 
>  # -I needed for generated C source (shipped source)
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
