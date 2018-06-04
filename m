Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1703727-1528121052-2-15184898297807857944
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528121052; b=jeBueFSl3eFNOtRpviIUIDlVIus69a9XwL9EdVB9wt2u9ftOOR
    uMF7RB8EczftgCYNAGrdgF32EE0H4UmgaUyYFAuBW6UwWJE3VNM8IlNp88+XMl8H
    AHWz/3MagCdXUuDpMchFHGn67DLvsBfuwsvI+z6YksXMjYPRm/JYrEevpzgRTtbs
    UlhazL0TqULYC/ClTZ8biNbR3+OmXJcgnHlgJ5gOEM98aWr9ILpyLKPI+GpPWnze
    EUdddb9jKmvSBkLKqqmJThsRIKnIpitEJUTKVZgux0PDFXk1+cN4SGaxS84PiEeT
    DHY+xMR6u+fY3RdEb+7YrBbwd9KcZXgoJSgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:in-reply-to
    :references:content-type:mime-version:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1528121052; bh=euMQP95/rcac
    UafrdNqQ5K4IY4BiMzzXAbVpMLuSzJs=; b=JhgRVttUKkhCjowdk73SOOlBWK1Q
    LZGIbiJnbTwi+ToKQ/EpbUfRwJC8Aojdmy4UgRazwAxSjX009kcon6YRPCeMXFYv
    uAv/pRP2X915Q3oDiT6Qnv1c9zC8bCRfnpRH/hiBj5flyahYQs3aR5CUCTPxcGij
    W6XKIO4ICQaNf/qT4ObIlak2SMY4CE7HPq60632fPalze+TCbiEg9uC7qp739Ad5
    VlUB2wj+VUzbZeo1tS3kDff9MNSiM8MN+Gx35QuSpW1C8XvSIe9hTISh7IAfBHia
    Yd1QbIeGojjmcrhIjwySPWoUhAKcIt1NNq+mh4wAGC30gLQjxMY4KHUwWw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfKsbYCmxbRvbnnZB/JlHICBF/SD1PqdQVEkFQsy5+Vkc4skF4KmSh+SFXx9L6WqX6Ew26TBcn96HyJTzB67i49PCrP6gnbvfuKIDLOcVWKO6R0c5YAVU
    ahavLFap1HLeoz89H5MWb+wjkBa2EUtvyOhcYdKnATn3wW1PfbSoRyW2h3BfB0cGQTAoopTIPnGInGndgWCwom+ku7MuZ4yutvyO8BenOsRES84+V8nHNoIC
    kvaE/DcXY1ppsnUMPyxGjQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=18aXAE-iQdpnPZATxN0A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeFDOEJ (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 10:04:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33273 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751933AbeFDOEI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Jun 2018 10:04:08 -0400
Subject: Re: [PATCH v4 0/8] kexec/firmware: support system wide policy
 requiring signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <james.l.morris@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jessica Yu <jeyu@kernel.org>
Date: Mon, 04 Jun 2018 10:03:45 -0400
In-Reply-To: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18060414-0028-0000-0000-000002CC87E8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060414-0029-0000-0000-000023830E2C
Message-Id: <1528121025.3237.116.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040166
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-05-29 at 14:01 -0400, Mimi Zohar wrote:
> Instead of adding the security_kernel_read_file LSM hook - or defining a
> wrapper for security_kernel_read_file LSM hook and adding it, or
> renaming the existing hook to security_kernel_read_data() and adding it
> - in places where the kernel isn't reading a file, this version of the
> patch set defines a new LSM hook named security_kernel_load_data().
> 
> The new LSM hook does not replace the existing security_kernel_read_file
> LSM hook, which is still needed, but defines a new LSM hook allowing
> LSMs and IMA-appraisal the opportunity to fail loading userspace
> provided file/data.
> 
> The only difference between the two LSM hooks is the LSM hook name and a
> file descriptor.  Whether this is cause enough for requiring a new LSM
> hook, is left to the security community.

Paul does not have a preference as to adding a new LSM hook or calling
the existing hook.  Either way is fine, as long as both the new and
existing hooks call the existing function.

Casey didn't like the idea of a wrapper.
James suggested renaming the LSM hook.

The maintainers for the callers of the LSM hook prefer a meaningful
LSM hook name.  The "null" argument is not as much of a concern.  Only
Eric seems to be asking for a separate, new LSM hook, without the
"null" argument.

Unless someone really objects, to accommodate Eric we'll define a new
LSM hook named security_kernel_load_data.  Eric, are you planning on
Ack'ing patches 1 & 2?

Mimi

