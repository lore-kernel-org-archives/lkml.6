Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2840403-1527635660-2-15694708423812809368
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527635660; b=dSYGrFTdsieJE0blaq0EkAOq7Dn9anqt0u8qCg84ckERyp3qyy
    6lob9VR549VmV9MHvh/6ekh6kcps0W2y0r982KPa5uhaScttlQCkk2k8iAN8rwze
    AopHq6ncJufE6ExejM3ZNbjRyxzavUnRrAT3u1CFzg8tDSkJf+NEgQLUJDUMxZux
    Y/dbcSJcwN3BikN7ZiOJ6dXGDn3sH82TtTq4wppaAHt2tB0X3tmFp/myeVacyIhq
    drB35HW1nBZi9/ANPRT/iY+FD/l7iHsS4VaFqInGY8hXNLgg6rmxbgTjZS0I3vwt
    62bg6HZSZUD4ywOxfdEoJzY37IgZql0nhAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:in-reply-to
    :references:content-type:mime-version:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1527635660; bh=OoVvJowv3qdg
    bNIU1/CPLMM1Q5Wp/1cEiUqUN6gimEU=; b=d/LnwVSesZXjJ8g8wvtsYxGCNsp2
    YvQydInWyeRHCFmcSbjiEq5+wk4cImEvjhWEeLw0rfsH2kHf7bfkCJ79XqRrB121
    Q0NhZn8P3qwGfm+2aQIR1u45N0UFlJsJGtEmfreuHxWnWdKWHVF3kIDfpNwoY1aV
    2BC8ANLne8nIRPhDG2D2oxV9E7j95LwvCdpIw/3ZHU8bIkClQrZpZdTsB+f3eVTh
    kpo25jupWY37aY6FtHKiy/kyY2FDQbkqb7l6z3aQu5aZfFY8NgAZjy9lIYl3hKkl
    yT8geO/b2hi64NiAd0KS0q3vzcfBZrFLcCbtnf8/6aH/+VuJ6+RzC9/veQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOFF9Da8/XPl/Qa6fJIFrJGO+aGMh5ABFRXNiDEaBvKaq31NgndGQg3o8ZntqGWv6tQsUfni5Y8P64FiKpK0KNoOZ5Fy5MZJAAZ9sj5v0wPqTcTZJFJF
    IgESroKH5nA8nVUthE+t6Sz8uuZbsKhkkysUsDLyBW/khcBEma6dww5qIH49gyiXtmgPGZq1n7vujtn1hl/kCDPERSTZzTmRGUyJLJCKhW0yI5Uzwf3DrgAD
    Cl5NLOQAXfLYvTJBv9ijfQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=2EN0ZrS2seSoPFHx16YA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967768AbeE2XOR (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 19:14:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965249AbeE2XOR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 May 2018 19:14:17 -0400
Subject: Re: [PATCH v4 8/8] module: replace the existing LSM hook in
 init_module
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Date: Tue, 29 May 2018 19:14:05 -0400
In-Reply-To: <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
         <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18052923-0040-0000-0000-0000045EB0EC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052923-0041-0000-0000-000021032401
Message-Id: <1527635645.3534.39.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805290247
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-05-29 at 18:39 -0400, Paul Moore wrote:
[...]
> > @@ -4043,6 +4037,25 @@ static int selinux_kernel_module_from_file(struct file *file)
> >                                 SYSTEM__MODULE_LOAD, &ad);
> >  }
> >
> > +static int selinux_kernel_load_data(enum kernel_load_data_id id)
> > +{
> > +       u32 sid;
> > +       int rc = 0;
> > +
> > +       switch (id) {
> > +       case LOADING_MODULE:
> > +               sid = current_sid();
> > +
> > +               /* init_module */
> > +               return avc_has_perm(&selinux_state, sid, sid, SECCLASS_SYSTEM,
> > +                                   SYSTEM__MODULE_LOAD, NULL);
> > +       default:
> > +               break;
> > +       }
> > +
> > +       return rc;
> > +}
> 
> I'm not a fan of the duplication here.  If we must have a new LSM hook
> for this, can we at least have it call
> selinux_kernel_module_from_file() so we have all the kernel module
> loading logic/controls in one function?  Yes, I understand there are
> differences between init_module() and finit_module() but I like
> handling them both in one function as we do today.

There's some disagreement as to whether we really need two LSM hooks.
 This sounds like you would prefer a single LSM hook, not the two that
this patch set introduces.

We need to come to some consensus.  (Comments appreciated in 0/8.)

Mimi

> 
> >  static int selinux_kernel_read_file(struct file *file,
> >                                     enum kernel_read_file_id id)
> >  {
> > @@ -6950,6 +6963,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
> >         LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
> >         LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
> >         LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
> > +       LSM_HOOK_INIT(kernel_load_data, selinux_kernel_load_data),
> >         LSM_HOOK_INIT(kernel_read_file, selinux_kernel_read_file),
> >         LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
> >         LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
> > --
> > 2.7.5
> >
> 

