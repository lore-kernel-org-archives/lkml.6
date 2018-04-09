Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240788-2-6140871237866720078
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240788; b=EFH1VkW3lc0g/+6nHTQyLws5XbQ6n/7Y1+AmRjNhsKKTlvm+3r
    Xwk0l0xb/zpz/hMVb+Hqq0tS0N7N29AvBPCdR6AOh6DwDei+HZTzO5lhrY0u9HXj
    wBZvtq6w+hX6fAJrCrRT3S+R4+MAKTRo2yHZ9y7VX4jL08G7atSRFBPQvblzPWdB
    A22RxKHKAxI5dwaN4Vsyc1Wx8/C/j5vi+QdIdsK32sGX0/CV3/m2BnwS2fo7QZxw
    0e3MSxCLvex9BzApBXeSRsZ7kvU7FE7T8MYMmHkn/WtBU6XEthlnklvoZHeG1Laj
    RuqkSTOJhUHMONiuq9N0r6+K/LlbanNFFHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240788; bh=YuRJvLHqH+
    p0RgluGh678LSdg0H3GKzpf18qHr7pRPw=; b=d/HMUatg1M8TbI8qNGeOgow4p5
    DsP0oAqzTg+iqqqgSb4At5K90bfQEu2f9Y8Q0OdXYwvRR6Ckyw5gUUGbTcec2A+o
    YuJIFKO6/gr+xTMTEnEzJN9Dv3PQEQWOqk3QMaEZ5nggr0AUaJKzA3oCYMaEKUhh
    CJip/ZChpyHdHRG7UnPdsl2MtoCf6mOnFtNxYkqWuCePaonsay7XpAWTB0F2np9V
    CqhC4YP+89kUafUtMqWiHBGiWajb7mLyU+giy/0QyaJcoS7mcBJst7MvRd/baZ22
    HjaZkOi5WFEKWuQ4C4WCr1mIp5mMQtuWzbFbNS+yPa1dv9XVHMswirLHx2bg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jYBYecUD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jYBYecUD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEac9Tblum5Tb/ZDvQm5FcyFZa532TVxuciz8uCNbKUhzl12K103sebOGdD9WjhRGxUptZZ0R1yuzOvc4CPlWPVFUiD16CUtTtm7uv6rwB6FqoJeeixu
    RpUNh4rcwwgNmQpVlQXGUddM/a6UlQJWxva2nvWmxAjG98ROHTOlTnW2Bob8DJszPYeu004iMt0S/sNCU0LE2V/BohCGWRMvgCZzoU/T8hYYWl7nurkY6XG3
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
    a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=iHonI5f4eHcSdlW7l9YA:9
    a=Xk7XMsatPKNtwq9n:21 a=HwlGJgPvOrfuUrOk:21 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756109AbeDIC0R (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:26:17 -0400
Received: from mail-by2nam03on0120.outbound.protection.outlook.com ([104.47.42.120]:61603
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754405AbeDIA3M (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Wang Nan <wangnan0@huawei.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Zefan Li <lizefan@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 095/293] perf test llvm: Avoid error when
 PROFILE_ALL_BRANCHES is set
Thread-Topic: [PATCH AUTOSEL for 4.9 095/293] perf test llvm: Avoid error when
 PROFILE_ALL_BRANCHES is set
Thread-Index: AQHTz5kTfZ+OYHksUEGPnCwtcFSLeA==
Date: Mon, 9 Apr 2018 00:24:08 +0000
Message-ID: <20180409002239.163177-95-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:7JM/OQaK83P1EYg3KwAlzdDe0rbzivTvcFlymrz3jFE+mSKtDTpnpEMIkqtNiNsSHICroomioHWTSdDTB0wYfukUuhfFOznIbdc5i+hHD+yvZDDfRnEu7FIokkSwvnmZnNH5DHlXSCOtwivDGaKkEEzfCCa0mwmB8zQ3vfW4RQMbmNolrfmDX0ABak0rxMt3+JWSMWJjzMRQl62PXuk6Vy0Bw91AVtATlPlaLNkTPBg5eu4N4qIUJZaDMj3jgBT4;20:865o+PDxYT7yAhBgIAGZ4Gmo75taGctI4lA2SdL+u+VayFxafZPSyFuRG4XrXI2edx693sNMwhDS1Yuj30olbVG+lHjVpUqwRa9dRLIJUJTF7+bGqvAc0rGEuswS4Kxqrz/GOI2nHDYhas9cxclz5T3Ycmlq87ekLMgDLA/4wU8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e51f77f3-3fec-49b8-8dbb-08d59db0e9e8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0967C2834F6F371FC1BD641DFBBF0@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(104084551191319)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(39380400002)(346002)(199004)(189003)(6506007)(486006)(575784001)(86362001)(14454004)(59450400001)(68736007)(102836004)(99286004)(26005)(3846002)(6116002)(186003)(476003)(2616005)(1076002)(3280700002)(86612001)(72206003)(966005)(4326008)(446003)(54906003)(76176011)(11346002)(2906002)(22452003)(3660700001)(110136005)(97736004)(316002)(5660300001)(478600001)(8676002)(6512007)(6306002)(8936002)(39060400002)(107886003)(6486002)(53936002)(81166006)(36756003)(81156014)(10290500003)(6436002)(10090500001)(25786009)(66066001)(106356001)(305945005)(7736002)(2501003)(5250100002)(105586002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: GNh2JJ9A+OHbg4dKGObo6wygy0P7r3jAu2iKvpuiy++JfxNaHxqJ88XXQsfV+ugJX9p4Q/z1Z4GUTT8Pc4T9QY2587wZGHjya7xZT2h+SIkuQMGmATQ2lYNuk/NX0CXj2gg8dJg4O//dP3VDL3eqCGIhAY5q51qo71GRaX7OxiksU+Rhza9JKz3CGisFohEAr1iqd3jKSa19J+w36Jzs9xKGeXM50URXAZ6jOjr+Y5enpwem2CljakC4Scl6d7/TfYsuq09hBI/Hng9smMvLl24Lb7IBniu/RS187sXXDS0DC/A+jtHoFWuGJOb3R7867ZqjHopqUZ5JhaCc36+uXA3RS2cs6vZhMetz+j6sJRthTEMDUuTTujlnKsYr0CI/JqX6v32BbNlKXbEgNC57uPHX/ZD8Ve+rXeDHMDTJnR4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51f77f3-3fec-49b8-8dbb-08d59db0e9e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:08.2218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Wang Nan <wangnan0@huawei.com>

[ Upstream commit 9b57fb7e35957c6838f89f4ed7e3f8433a4bbfc5 ]

The 'if' keyword is a define that expands to complex code when
CONFIG_PROFILE_ALL_BRANCHES is selected, which causes a 'perf test LLVM'
failure like:

  $ ./perf test LLVM
  35: LLVM search and compile                    :
  35.1: Basic BPF llvm compile                    : Ok
  35.2: kbuild searching                          : Ok
  35.3: Compile source for BPF prologue generation: FAILED!
  35.4: Compile source for BPF relocation         : Skip

The only affected test case is bpf-script-test-prologue.c
because it uses kernel headers and has 'if' inside.

This patch undefines 'if' to make it passes perf test.

More detailed analysis from a message in this thread, also by Wang:

The problem is caused by following relocation information:

  $ readelf -a ./llvmsubtest3
  ...
     [ 5] _ftrace_branch    PROGBITS         0000000000000000  00000260
          00000000000000a0  0000000000000000  WA       0     0     4
  ...
  Relocation section '.relfunc=3Dnull_lseek file->f_mode offset orig' at
  offset 0x490 contains 4 entries:
     Offset          Info           Type           Sym. Value    Sym. Name
  000000000038  000b00000001 unrecognized: 1       0000000000000000 _ftrace=
_branch
  0000000000b0  000b00000001 unrecognized: 1       0000000000000000 _ftrace=
_branch
  000000000128  000b00000001 unrecognized: 1       0000000000000000 _ftrace=
_branch
  0000000001c0  000b00000001 unrecognized: 1       0000000000000000 _ftrace=
_branch

  Relocation section '.rel_ftrace_branch' at offset 0x4d0 contains 8 entrie=
s:
     Offset          Info           Type           Sym. Value    Sym. Name
  000000000000  000200000001 unrecognized: 1       0000000000000000 .L__fun=
c__.bpf_func__n
  000000000008  000100000001 unrecognized: 1       0000000000000015 .L.str
  000000000028  000200000001 unrecognized: 1       0000000000000000 .L__fun=
c__.bpf_func__n
  000000000030  000100000001 unrecognized: 1       0000000000000015 .L.str
  000000000050  000200000001 unrecognized: 1       0000000000000000 .L__fun=
c__.bpf_func__n
  000000000058  000100000001 unrecognized: 1       0000000000000015 .L.str
  000000000078  000200000001 unrecognized: 1       0000000000000000 .L__fun=
c__.bpf_func__n
  000000000080  000100000001 unrecognized: 1       0000000000000015 .L.str
  ...

So I think the failure is because you enabled CONFIG_PROFILE_ALL_BRANCHES.

I can reproduce your buggy result by selecting
CONFIG_PROFILE_ALL_BRANCHES in my kbuild:

  $ ./perf test LLVM
  35: LLVM search and compile                    :
  35.1: Basic BPF llvm compile                    : Ok
  35.2: kbuild searching                          : Ok
  35.3: Compile source for BPF prologue generation: FAILED!
  35.4: Compile source for BPF relocation         : Skip

Simply undef CONFIG_PROFILE_ALL_BRANCHES in clang opts not working
because it is introduced by "#include <uapi/linux/fs.h>", which override
cmdline options. So I think the best way is to undefine 'if' inside BPF
script.

Reported-and-Tested-by: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Zefan Li <lizefan@huawei.com>
Link: http://lkml.kernel.org/r/20170620183203.2517-1-wangnan0@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/tests/bpf-script-test-prologue.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/tests/bpf-script-test-prologue.c b/tools/perf/tests=
/bpf-script-test-prologue.c
index 7230e62c70fc..b4ebc75e25ae 100644
--- a/tools/perf/tests/bpf-script-test-prologue.c
+++ b/tools/perf/tests/bpf-script-test-prologue.c
@@ -10,6 +10,15 @@
=20
 #include <uapi/linux/fs.h>
=20
+/*
+ * If CONFIG_PROFILE_ALL_BRANCHES is selected,
+ * 'if' is redefined after include kernel header.
+ * Recover 'if' for BPF object code.
+ */
+#ifdef if
+# undef if
+#endif
+
 #define FMODE_READ		0x1
 #define FMODE_WRITE		0x2
=20
--=20
2.15.1
