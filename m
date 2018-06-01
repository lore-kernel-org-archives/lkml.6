Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4022287-1527894310-2-14768048044391366076
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527894310; b=Qzl7xdcDuxayyyeO6Ollz5wqEDWouwOeWTD5LKZ3s/xoyR/p3x
    B+5q9otm2QWrvlm1T/2Koze/aGRNh9k5eI3YTtioEGAz7s+kj5Cu9SKKNb8z8tUX
    PVu1HzAGimNwJXyihTpVeAq/RCvUfH+wV7z3BhbXGfp0jb9p9FSZZ5GPRFtll1p/
    zkzUV3Wsjzksk5wUjaPAWAvJkK+yEwvn0osM1iuzn6WO+G+eyv8WeyEEdFQWoJDS
    9tiXiY7Tj7KPyajFtlJsaoQyw3pv/CdZuajrbEfHscT1Ys3K87C6CXhAcDM076gA
    jpAxewe82JBWz6haMbGSAbeO9C75QWibGDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:in-reply-to
    :references:content-type:mime-version:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1527894310; bh=MEwO7ZK6vRAZ
    OPJH9mZv/Qz8OxMoTCbWjUnl1A3fSsA=; b=AOX0YDzfUw4z5w+tN+E7U2F+uCmi
    aAOObbuaD3xTmN8Rd5GMBf6iobMjcMgDX/rXkWUezeBy/9WlCpd7gLIOszdFSVtF
    tOmBqoi7pgo522S6NYlbaKTvYgJRiDcXtI7edVbk3ZW8j7nWeBrk42Jycc2XmeyS
    1egHoI75msRocFyGTq2IksiH6I5dDNvKP3eAEaZdyiytRrvWOROx9An798m+5+a6
    JbHGA0ItszQNKqyW48OZ8RXv/7i4l4gWfzFKMoTAgLHiMBhzzyzKrPQEphuiB5hv
    4GoHv1kySpKOXIrSdG9LOmKmXwaTvt5zxRdxIr32b/af4pV+bATpL3olbQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfGv9a/V62KeML+jIE38I+3WiWM5filDxjdVajj8T/bTEAHDZSBJ6hGlg1Ww/f1vzCesFeH6ozWNmw6tDBI2s4zM62Bin89NEzWJLjh/cRAP/Z06la6Yj
    hPFC0zZUB8H9MhR8iupQGLV3XdLXS7dBc0xXQ+VK2HYI4PCGdALnRHgY0yNhSNgo/2EKMbJCuLgtLZYN6m72UX8tutpnMsdy9sPmO23SQg7kXVC2ItWMZzRU
    8G4iTXHzD5zIt5lji9h6dQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=MHHIsb35nnmMI01UwDIA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750869AbeFAXFG (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 19:05:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750724AbeFAXFF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Jun 2018 19:05:05 -0400
Subject: Re: [PATCH v4 5/8] ima: based on policy require signed firmware
 (sysfs fallback)
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matthew Garrett <mjg59@google.com>
Date: Fri, 01 Jun 2018 19:04:45 -0400
In-Reply-To: <20180601224617.GU4511@wotan.suse.de>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1527616920-5415-6-git-send-email-zohar@linux.vnet.ibm.com>
         <20180601182107.GO4511@wotan.suse.de>
         <1527892795.13403.26.camel@linux.vnet.ibm.com>
         <20180601224617.GU4511@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18060123-0012-0000-0000-00000279E326
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060123-0013-0000-0000-000020AA9858
Message-Id: <1527894285.13403.43.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-01_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806010261
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 2018-06-02 at 00:46 +0200, Luis R. Rodriguez wrote:
> On Fri, Jun 01, 2018 at 06:39:55PM -0400, Mimi Zohar wrote:
> > On Fri, 2018-06-01 at 20:21 +0200, Luis R. Rodriguez wrote:
> > > On Tue, May 29, 2018 at 02:01:57PM -0400, Mimi Zohar wrote:
> > > > Luis, is the security_kernel_post_read_file LSM hook in
> > > > firmware_loading_store() still needed after this patch?  Should it be
> > > > calling security_kernel_load_data() instead?
> > > 
> > > That's up to Kees to decide as he added that hook, and knows
> > > what LSMs may be doing with it. From my perspective it is confusing
> > > to have that hook there so I think it could be removed now.
> > > 
> > > Kees?
> > 
> > Commit 6593d92 ("firmware_class: perform new LSM checks") references
> > two methods of loading firmware -  filesystem-found firmware and
> > demand-loaded blobs.  I assume this call in firmware_loading_store()
> > is the demand-loaded blobs.  Does that method still exist?  Is it
> > still being used?
> 
> Yeah its the stupid sysfs interface. So likely loadpin needs porting
> as you IMA as you did.

In this case, it doesn't look like the call to
security_kernel_post_read_file() should be changed, which means that
all the LSMs and IMA still need to support !file.
 
Mimi

