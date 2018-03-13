Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-126535-1520983235-2-153332172447302951
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520983234; b=uc968lo5a1br7fJejBNFGnP5ocmShP245gh0h521CkoYwdI
    q1dK9ENrLHwc/BvLfFScV4UH6hx3paOYnJSSnXnp1oUjcRzgsMTcat5Hs+tv8p1w
    1D5g831nfVR92+5D7lSV+REaz7HEvzx4iwmvXtCuvSy8e8af11zguMr7ry7vYeLk
    EmXb34vnUbFMQYN77D1gEdlmABZXTpXVpn9UR8Y073N2DauLAFE+nvTmnTRy4T5O
    sqFDioUy00u/7Ji8J6bxN5l6URDqe5CsfC7+m7iOpXii/kkzM6KP00Mt05DTGUiR
    tkx6vlzsfYiqx9nQ9XNjHUh/S0o8WRJOQrsy+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1520983234; bh=964J5vx2xW9xfnJjJEbWmeQQeGi1Nkd+0P9rtdyGl4g=; b=s
    yyjND6D3r2nY/SAi/yjLGZlsXvVF+V6EwDD1bys8D8iruMVehbwhpbaI7ylINjCu
    +m15lt1RhAzk5CbJdkAjT0Im+PoXjemJg2be7ZaN71Eco+TNbyaDiQj6GHngq+fy
    9UBaIXhtKPjyGPHU09RWcCm5LluLcS8Ygmxo1geo2LQVpBqI6G25p83ezoSMOBK3
    Gcsj2/Srrv7RNe7yp1uF8MpL1kG6MM6TOtXzM50+QhZ+NmsjSQlrwU0yKs19MYRg
    qjnjQcoLuhQOlnca3FRLJbQBWJ2hI0o0ZWXT/qDZlB3jnc7CQxZhvcopPdkdVwkw
    Kcu+awsMuIGgKVlmupUiA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=Z5K6H3ns x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=VPzk3mVf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=Z5K6H3ns x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=VPzk3mVf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932360AbeCMXUc (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 19:20:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43862 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932240AbeCMXUa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Mar 2018 19:20:30 -0400
From: Howard McLauchlan <hmclauchlan@fb.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-api@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yonghong Song <yhs@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Garnier <thgarnie@google.com>, <kernel-team@fb.com>,
        Howard McLauchlan <hmclauchlan@fb.com>
Subject: [PATCH] bpf: whitelist syscalls for error injection
Date: Tue, 13 Mar 2018 16:16:27 -0700
Message-ID: <20180313231627.1247-1-hmclauchlan@fb.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:747]
X-ClientProxiedBy: MWHPR10CA0051.namprd10.prod.outlook.com
 (2603:10b6:300:2c::13) To DM3PR15MB0539.namprd15.prod.outlook.com
 (2a01:111:e400:c477::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e02040bf-218e-4fef-2edf-08d58938f1cb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB0539;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB0539;3:HNmFNIsqrNb0OK2EBqe85+dmlwuZdRzxKK+Of9ICZmh7mjeFCB9Ujk8rorwmKgvHFqdm7H7quRIGIMQCVKDo1Xb59MEwJdX5DItvXsSWzI69P65kOsU7nPqyHgCseXIA6uTW0BZp72emtjL8KUvJLzktEgD5ui9l6UtOQFXnSOU1o+05AGo6anair+jYkzfWvz/VTn0oJ4aOAqzJK2b8re2RipDkI3o36ZVTivMAYE6oSkoNpvTgvlLVTCF//Juw;25:5guWVcCxCvMdGZFHW7kypm88E9TVclUQ935yG6PyPdauxMGfnDUYBq2Uj/Ibe8vhpNL7JYbPDAUmGihi30zbq8wuTs0zjA4KTGQy0FLicIF2DRRhAPSTmBdF8OTjbTYlvfwDv2h6VD3sdo8b9A1BVhteqb7z9i+uxn2Eu6k6eWzd8i3GMo4WcnIpOtoZkIN553i+dwRew0WWxjR9LntaHB2IQejDGlG5XOcSwqFqv42rx7dJr2UyqZ8JgZ9LSYNtatxmQloqEeT1JHf6foY1LsQAl8/gX3dQ7B9whFRhI2uK64i0z76XYUShNf75UDV3jX41Hk8HMvUiPg/a14GZxEQI8/MPpIwFqwcYsNq4U/k=;31:7kd965S1/1HtsKPGKA/hxfpN4Zqo3WesN3UTLtpGm4+/GjSErd/ByhIKE8Cd/PltTRJaPot4llhwqlOI5EiZU/0djc7wdjrKTJrT4oSMFA1vARZE1IA28oD5BCXjMm/KHqeAmd+OQWs8vNdLX6VaC5GhNIIPQQVt06O9nPiqI+K8aFWjLE+COTReVAFgKh0B379mH22dI/LyYjaBDAyhbEPMuMs2qudkZGfG4LUwEdk=
X-MS-TrafficTypeDiagnostic: DM3PR15MB0539:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB0539;20:BKyy2WhJqRzpk9Hjl94RPxT7q0mwmR0OPl1xoYEZI7MhkxOfy4MUDeMpzyiuA2n5Z08/PbttovPB32FXC0LBVINRu+f5O/EMn4Xvg/4Mh38urzz27jQSm1b33sahD9pfG/P3PVNMThglbyNAEyHRv1x0rR1JcU08UwJnvRr/GSvpTed+CzspBM7DQIR2CcUkrgoXOCT0CW17pZNfNcWI7ZbwOrJSA4UUwV1oJw2J43YKxGMZYuPpfMTpg1TsA/qRyxmc7TVuaTkKBKiXHBtVjKh9882OYLB5sRBGpzrbVREeaGziX+nA303ciBkJh7KlL0X/G0pczptJP/bjPz8ctjk9gYo0EqPOuqc7YC8pcC5c7gPKUhIl83BojRZ/kRg6jP9nr7KC3NG5kitNt11tcxxSqx29uQxAm94emxdnoGTdiG5Hik1Ujxz2AK8t+pbvXJw3vzjs/JtMyPZVIiKR/seigZ43O1Iujv1xs2ZmDq44H3kPDB5xHpErL/OB/6O7;4:MgfKHya8gvSonGiRkSTUiZpk5x0RYCY2sAjV0hqHAZ09DpjcFhapeTcnpR7tgzBNiZWuSuoUoOb9XJDfPs2NQuZEV0YJXurVBdNvd5J4Y26F4IpMKejWZDlGt3bNNBLzznTihwaxBgVIeX0JxyzzKNM8Pxppa7y5cpcCEUV013V3CnTN2ISsU7OSbm/dhjOS5Pl7sazWF/PgFFkSPzJqXw2/C/xIB8McPiPnWEsF+wOXRZEewvJFSqDav23iibRqM1nNb0KhRyQ1mc4lWvBoL80OJPHvlBmZz413gfvzUQojdu822b7Qk5uDnypJzKXv
X-Microsoft-Antispam-PRVS: <DM3PR15MB053903C5ABAEF01E855A30FBC7D20@DM3PR15MB0539.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(11241501184)(944501244)(52105095)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM3PR15MB0539;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB0539;
X-Forefront-PRVS: 0610D16BBE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39380400002)(39860400002)(189003)(199004)(48376002)(8936002)(2361001)(16586007)(81166006)(1857600001)(53936002)(4326008)(86362001)(50226002)(5660300001)(36756003)(47776003)(81156014)(7736002)(305945005)(25786009)(8676002)(6506007)(52396003)(69596002)(50466002)(52116002)(51416003)(6116002)(386003)(16526019)(106356001)(6666003)(6486002)(1076002)(97736004)(53416004)(2906002)(316002)(105586002)(6916009)(186003)(6512007)(68736007)(478600001)(2351001)(46003)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB0539;H:hmclauchlan-ubu470.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB0539;23:5fuH3kAU4OuD8UihsNhVE7uV6xw+zxsQlP59oxAzj?=
 =?us-ascii?Q?2m7SV3L46Ic7oeWVyng2eeQWYhHacMWtsYVx2WE5sfBW77TEppHAjm8FMWaI?=
 =?us-ascii?Q?RHDNbYJEEvMbPOl10DOa4cJZyJFwLG1W0sxQMZ86ywIoVTQj2i/soLQB2vBz?=
 =?us-ascii?Q?70UIhAgMKbxu7kEg2jKCxfduEeTDJhriUSR9zEg9TbeWtl95muhJXYprEn0j?=
 =?us-ascii?Q?gK9YJRwmqaKjaWTpoAkJLHyka7/L78DhCeHuprltnX8dQSIlVgonzCPtJVJ1?=
 =?us-ascii?Q?Uxg0cX/wz4MR/UWLeFuyYGEzx2Ecle6PhERh9AclBk002A784ceA4nmVRvId?=
 =?us-ascii?Q?wJmPbWQLGhtfQdbc1UGJ+y9HtC0as6BdjYVFNotqA04HmSWu1LhKYbnCv5hy?=
 =?us-ascii?Q?FeI/n/CkC8YDCL0GTG6DUlKDvREWTs41EMf6kGwuQQlfJmg9L/UyaZpDwmbU?=
 =?us-ascii?Q?ADN4SH/CX/cL0W4rqJPeMmNO4Mrrmfx3+cj+dtfuAFFuNFd5I+9mEy7MenC8?=
 =?us-ascii?Q?iTSCHp15sqmTyaRBjnF63QQRck34ygM5rN67Idv0OwCdMF4t4vOaDbRadUFV?=
 =?us-ascii?Q?gFxNwftzp/zK+1vsdRMxvfO5W1ZeSPVglErxGYmEqT7cWRoyvFSuygw09QMd?=
 =?us-ascii?Q?fjpem9HZ0CHJPxBCaTmOumDBpoAsPhTvmnYNv0qCmaBom8qFl7j9A4tYIB/9?=
 =?us-ascii?Q?76Ve+mAd7Aq2J+2xeZybXfAO086ehIBMcT4NS+9rQG27Ba0WHiZsrV+EFnJ4?=
 =?us-ascii?Q?3zIhNVNUmkGXuRmo6UHHgmd8WjMRpWT7fjmVc12VGOrBqV3fxBsUosNVuUIv?=
 =?us-ascii?Q?HzH2+oY2KNMzaFbqw/FgkxnOM15duh3wF1upXaFfYK1lKBrSKNtt90WW3HX8?=
 =?us-ascii?Q?AtT+xUG7VVgEd8206hCRjx4k7ySbZ5Vgs0f+hFl1u/vKrs6TKVwrMR4IyUjD?=
 =?us-ascii?Q?yfufil1vtGiQUjv9M4DgdSUMSqd8kivLMDqsyJnp6kcNBRuBIwyY+odzcc4P?=
 =?us-ascii?Q?1LglBVuPa3TVx3WIVGOj0ID5i8nRrEOLNG8ilqY1DkvD52HThxLNZI7hBldN?=
 =?us-ascii?Q?5S0S3VWmN19iL3l7AUMWMEEyxvN0YaGeidyHUlkVIJyYrqyg13Dr6VsiKqAw?=
 =?us-ascii?Q?gpxEhyVlywrhljw/yS4q9AbJfzV7XLKugsMoSyPA0WfBCvt34msuRuPDWdlP?=
 =?us-ascii?Q?2+Bm1A86oCHHIw=3D?=
X-Microsoft-Antispam-Message-Info: u2V9+3ggxevkHcJgrNj2RCN+ax/kCon91CiJ9kg6elt32tu7MSx4eFNqnBAj9rZR9DVVW5JLDHW2Et1b25ceCA5d6Ob5ni5ozwKCA3HDykP2BTeuLdQO9kJYFo+LFoA37R5ej/HxhB/2u2SfdShCYbcPeC1+eqO7C2iyLl/rBzRWvMLVkuhx+W0+qGevsFIL
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB0539;6:EtDwXQJS7yOdbzPvI2jBQ/HCzuFvvEQDIQ+9N6Y+//s7QirflcovWtKXaVC4Uzf/9+/Nqwms9n0djPhdSu4iR5EIlznNj/VJ6eebseXUayNzPjXGCPPZINxSDRfw1bJ9R2Cf4Wqj/1FKJcsjC7y2xJCwCAeTnQybz3gWl9uHj1d1JtknS3Q/eoBSM2CoTSW4XG4S3erC1u8tYWk361aUl/I3ZnRCMysxHJ2C6g/aHaE+qmhi12znKF21Um2ehiMtdvd+vliSXEJVC8r/1cm8APr4gl1eGF5RC6O4o742zTQ5zWxEkFawQ4eWwmAm3p4mrPzwj+qU9GJ+0he7+ue5TP660mk0yHmkblbxze+iK4A=;5:fvGhLJPpLnsDWuydPwSCqPQn06a8BMKnJbsqt9c359sFKvvDF1z6voVnFRwC0WN9PObWt/dm4h21b/BvtXhvyEYCdZVZZPEwKbWqS5WlhYld5JNIkX/WKRMzgYFf7tLXYrsZ9X6HK7YSWwbcSFqZjZkdfzWXlPRNW+Fn7UHubyw=;24:quLbVaMM4aD+n3XiIQiGGdeLrNDnwRjBcJl+t4To7YIiV4aPsfi9i2iSjbtVd6sElJDy1amKp/suTXe+PHD3wI4aTpChCKhv2YIJch93jgk=;7:A8sFmxsWEvhGjilQpguzLORA/d5QOa4Y02lQ49ONc5qwuKJ/D5WepCHKSgye6RGBBAwkx6DkPhHPMiNIfLwpRx184AFDASUz5B9PwvsNsPugzbVIccAKxFndWaDcEgC0YhdSYcVR1qjl3AYzsNbq1d10LVrtHCmd9rsVAOJHdJWIWTl6z3X64mpDQZhxHLNjpbzL8iocQ+b6f8lZkMVqVE1CYrQEvpD0WAr4MahMq3YesaU2PxySB8JTlf1DbW47
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB0539;20:H9FIRv6jYY2isqx81rcVuyjlzESPnr8NJuPDJS1ucPg16uKJKrjtc9NilqFSBoTfFJuMvLV5yujFuVUJhUl5F5yW4HQCyrPChPmGbx1kN3JrhJR4+hnLLhEgOb2uwjqyh2rIRI82tYShNm2u1iTOWZg8OGFOqNDJ4tO2XZAfMWc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 23:20:00.4185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e02040bf-218e-4fef-2edf-08d58938f1cb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB0539
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Error injection is a useful mechanism to fail arbitrary kernel
functions. However, it is often hard to guarantee an error propagates
appropriately to user space programs. By injecting into syscalls, we can
return arbitrary values to user space directly; this increases
flexibility and robustness in testing, allowing us to test user space
error paths effectively.

The following script, for example, fails calls to sys_open() from a
given pid:

from bcc import BPF
from sys import argv

pid = argv[1]

prog = r"""

int kprobe__SyS_open(struct pt_regs *ctx, const char *pathname, int flags)
{
    u32 pid = bpf_get_current_pid_tgid();
    if (pid == %s)
        bpf_override_return(ctx, -ENOENT);
    return 0;
}
""" % pid

b = BPF(text = prog)
while 1:
    b.perf_buffer_poll()

This patch whitelists all syscalls defined with SYSCALL_DEFINE for error
injection.

Signed-off-by: Howard McLauchlan <hmclauchlan@fb.com>
---
based on 4.16-rc5
 include/linux/syscalls.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a78186d826d7..e8c6d63ace78 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -191,6 +191,8 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 
 #define SYSCALL_DEFINE0(sname)					\
 	SYSCALL_METADATA(_##sname, 0);				\
+	asmlinkage long sys_##sname(void);			\
+	ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);		\
 	asmlinkage long sys_##sname(void)
 
 #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
@@ -210,6 +212,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 #define __SYSCALL_DEFINEx(x, name, ...)					\
 	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
 		__attribute__((alias(__stringify(SyS##name))));		\
+	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
 	static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
 	asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
 	asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
-- 
2.14.1

