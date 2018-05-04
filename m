Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeEDCAY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 22:00:24 -0400
Received: from sesbmg22.ericsson.net ([193.180.251.48]:63562 "EHLO
        sesbmg22.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbeEDCAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 22:00:19 -0400
X-AuditID: c1b4fb30-4c8039c000007681-d9-5aebbeb01550
From: Jon Maloy <jon.maloy@ericsson.com>
To: David Miller <davem@davemloft.net>,
        "syzbot+df0257c92ffd4fcc58cd@syzkaller.appspotmail.com"
        <syzbot+df0257c92ffd4fcc58cd@syzkaller.appspotmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tipc-discussion@lists.sourceforge.net"
        <tipc-discussion@lists.sourceforge.net>,
        "ying.xue@windriver.com" <ying.xue@windriver.com>
Subject: RE: KMSAN: uninit-value in strcmp
Thread-Topic: KMSAN: uninit-value in strcmp
Thread-Index: AQHT4w7E3PkdMHfNsEiALggqmzHyM6QeYfaAgABskDA=
Date: Fri, 4 May 2018 01:58:46 +0000
Message-ID: <CY4PR15MB157567D1E7FB74789CBAB6D99A860@CY4PR15MB1575.namprd15.prod.outlook.com>
References: <00000000000059f907056b519603@google.com>
 <20180503.152213.740988890883315228.davem@davemloft.net>
In-Reply-To: <20180503.152213.740988890883315228.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com;
x-originating-ip: [24.225.233.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1784;7:CS73fGKwkMm2W61tRKlciDjw6rETkAQUSx/f7HyGiEadqa8mSA4cH+MYJ1BLhDPvDN+oxxJAdxQH574EpPGwDbNT9VATwnbNIZK9tSkUdPm3INFoo4n8YNQNUJJVM66jn8ddTDcCzNf+a0oSjQ0uCZnLRUdkXIAESCOxPkqVCRBhXx2yV6mE7JV9rk2WSZUc8W905x9gGo6hfpyTwsTjDotrTc0bJYFRVSAn+2PUJUNwKgU4SYVWaPyBEsGK3/88
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:(215639381216008);BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1784;
x-ms-traffictypediagnostic: CY4PR15MB1784:
x-microsoft-antispam-prvs: <CY4PR15MB178490C8401A6DFF9C9CB2689A860@CY4PR15MB1784.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(143289334528602)(215639381216008)(9452136761055)(42262312472803);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR15MB1784;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1784;
x-forefront-prvs: 06628F7CA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(39860400002)(346002)(396003)(366004)(199004)(189003)(13464003)(486006)(68736007)(55016002)(97736004)(8936002)(74316002)(316002)(25786009)(54906003)(110136005)(5660300001)(476003)(11346002)(446003)(6436002)(6246003)(478600001)(9686003)(86362001)(66066001)(2900100001)(229853002)(6506007)(76176011)(7696005)(186003)(102836004)(6116002)(3846002)(3660700001)(59450400001)(99286004)(4326008)(2906002)(53936002)(53546011)(26005)(3280700002)(81156014)(14454004)(8676002)(81166006)(305945005)(33656002)(5250100002)(106356001)(44832011)(105586002)(7736002)(129583001)(17423001)(156123004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR15MB1784;H:CY4PR15MB1575.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: YDZbNlIcAO6QJPrbLnByf/zJuHwk/I3jAbr7EVhrQQZZd/do5kHyt9yUycqnvHvPDna1abALhOwMQ923/4MWYSLHI9cepJtjG3iyagh0Vh7qsQbPhWHnBXrH2EoDDvt9IBtb141cHauXASTclLcwN1JZWEzKCroeq3m9eUFrYwAdznfVamUKdaTELnPJxcRc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e20e56a3-92f4-42b3-4c7a-08d5b16292cf
X-MS-Exchange-CrossTenant-Network-Message-Id: e20e56a3-92f4-42b3-4c7a-08d5b16292cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2018 01:58:46.9044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1784
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec85m8fL7G15eVAKnJXhLTWxkdmNoiElQREqQk496XKbtmOm
        2QcNP9gUMnC2ecFpsyy0hi6z1MQLivbB2irNILOpZUM0LxmEkvMs6Nvvef7/5/0/D7w0KTTy
        fGiZModRKaVyEd+F0sU/vxBifGVLDHs3FimuGS2mxJaXNXzxoN5LPKE1IPG4qZYUm0aviK1j
        Y+QxJ4np0UdC0nV3mC/p1C8TEt38Xsly6y7JU9Mz4hw/0eVwGiOX5TKq/UeSXTJ69MNE9hPX
        vJaFe06F6I2zGjnTgCOh5cMvnhq50EI8gGDAVExyRRuC7oVVxBWrCD5bVvlccZ+AbvMGZZ+n
        8BIB6h5/Tqgk4EfTW8fIVwQL/Q3I7uLjfTBXWbLFHrgaQclIut1E4iECNPoR0i7swIFQNKB1
        mILAqJ108CGoetHG4+J2w+CcYStagJNgpcjmpEb0Zlo2NH4Ks7ed8SnQGMxOdkbYC9ZGmgk7
        k9gbJqbrCO5qDIauUZJjT5izbvDszyCcAK9nEri2H4waGxyWnWCuK926C7CJgPnZRR4nhMCi
        RkNywhAC89QnPicEgnGm1cGZUGKtRRwXwMb7WoIbaCRBN6ulylF41X8LchwM+s4lPsdB8KDe
        RlZt3bwdhnXTlB5Rj5Eny7ApivSIiFBGJUtl2SxlqJLJaUWb/6jX9CesA819O96HMI1EboKx
        dluikCfNZfMVfQhoUuQhSBJttgRp0vwbjCrrkuqanGH7kC9NibwF4ri2RCFOl+YwmQyTzaj+
        qQTt7FOI6PPtRPLD2J6zTFSsZ9XktquLJ4vH4wKyCjoUzVF7+stiotembl0+KgiSZ1nMWtbj
        wExAzGrZRSwxaNYXI3qvK9S+5anxMPtddtpd/ns4OtPvRH7FuOu64vZBYbC/TTpTmqernjam
        yDpsTe53GurXz/y0GFYYt4pmq9Xy5WaciGIzpOGBpIqV/gWdGqDwQwMAAA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4420V9u029489



> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net]
> Sent: Thursday, May 03, 2018 15:22
> To: syzbot+df0257c92ffd4fcc58cd@syzkaller.appspotmail.com
> Cc: Jon Maloy <jon.maloy@ericsson.com>; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org; syzkaller-bugs@googlegroups.com; tipc-
> discussion@lists.sourceforge.net; ying.xue@windriver.com
> Subject: Re: KMSAN: uninit-value in strcmp
> 
> From: syzbot <syzbot+df0257c92ffd4fcc58cd@syzkaller.appspotmail.com>
> Date: Thu, 03 May 2018 11:44:02 -0700
> 
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:17 [inline]
> >  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
> >  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
> >  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
> >  strcmp+0xf7/0x160 lib/string.c:329
> >  tipc_nl_node_get_link+0x220/0x6f0 net/tipc/node.c:1881
> > genl_family_rcv_msg net/netlink/genetlink.c:599 [inline]
> 
> Hmmm, TIPC_NL_LINK_GET uses tipc_nl_policy, which has a proper nesting
> entry for TIPC_NLA_LINK.  I wonder how the code goes about validating
> TIPC_NLA_LINK_NAME in such a case?  Does it?

I assume that a strncmp() instead of a strcmp() would avert this particular crash, but it doesn't sound like that is what you are after here?
To be honest, I will need to study this code a little myself to understand if there is more that has to be done.

///jon

> 
> This may be the problem.
