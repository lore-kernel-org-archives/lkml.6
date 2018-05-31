Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1592812-1527778849-2-14727206827882814480
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527778848; b=bZJwcMljdpfB6vUvP0bIIaZash7r7Z6H6PijRPlia3zjickfF7
    68LjgKDgIMC0U6b/EfQQY6WX2KkKkuXPa3t/gCBU/FQuqRfTemUrHUEDdmEkCDt4
    r0DEgswMIOUQ13tbA39hdvVuExUzPTaK5PRiP+LHBkszg6FuQ6NMhz2BDzhxC79C
    6MSOtmD+NaH/8rjEAZpf64ygWR9icrec4IbQ0y/3osjTOez+RciGxRYQKYPjer40
    N5tz7cSmenoRqmBkpo2CYHNxtoaGtF8Pux/WAQDfKBbNBLp7VYCauPnyJ6iroP85
    5nDe1KUvKtYSaAlQZpz9YT6Ua2WqsMd6KxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:in-reply-to
    :references:content-type:mime-version:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1527778848; bh=XfRrLtWvbuAJ
    BhpNzsG8RBXKGi+SqdYFJoUksIz+AUY=; b=CxDS6ONrxZpKbuQ76e22z6Z6CF9G
    tMg0Ol3+NZS/yMxnmLowTzIVdazbumoIueCosqYGVkNbJRL/NzZXYaAvTKXVafOe
    Y4SaO9BOWIfXH3g/zcc4VRM8wasC5jtYjYWuq40x84TzPksDjnifuXQi081C/KC8
    VRoKpO7rAKl0bToMPpXD96Tg9bLKlYiPXvhNfHYf2i6UwmX/GPXD45LPaLHrHIVs
    Epe620bl1w29FXCDkS1irFyfRQP0oXDnlj+1QtrDUT96vgZuWZ1gad3e4CaVWKVj
    TjW209nj/7UeckcXvUzCHozEosvF+Y6qh+s60X2Z6CxMk+bY8uC0jURMOA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfIkhrXS6M3mh4tQXHWdZ7Ka6DLBoypIKdqjjajdTKFLf4QLUew+qFyWADUNINyXG2FNoHYlp6dVYu7Pal5i/T+iCDTQKM8QfG9gXOlvlE7fG4uOi8QVQ
    dLf4gpi233Q93QI9t0TUDi3fRVIVN07FsYjsk+06kyRXGAl9G88DHHE97ERqLB1pn8jb8aur0EP36bO5j0/4AfoR8w+V5R/tmYl+IaWgsLR1cukVIq4JsEPe
    BSRCnWja3W1jULqDaTi2Mg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=DnAUPfl5-9z4B3bKB2IA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755369AbeEaPAo (ORCPT <rfc822;linux@kroah.com>);
        Thu, 31 May 2018 11:00:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755311AbeEaPAn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 May 2018 11:00:43 -0400
Subject: Re: [PATCH][next] EVM: fix memory leak of temporary buffer 'temp'
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Colin King <colin.king@canonical.com>,
        Matthew Garrett <mjg59@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 31 May 2018 11:00:22 -0400
In-Reply-To: <20180527221502.25073-1-colin.king@canonical.com>
References: <20180527221502.25073-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18053115-0020-0000-0000-000002956846
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053115-0021-0000-0000-000020E0E6E4
Message-Id: <1527778822.3427.13.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=974 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805310169
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 2018-05-27 at 23:15 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The allocation of 'temp' is not kfree'd and hence there is a memory
> leak on each call of evm_read_xattrs.  Fix this by kfree'ing it
> after copying data from it back to the user space buffer 'buf'.
> 
> Detected by CoverityScan, CID#1469386 ("Resource Leak")
> 
> Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of verified xattrs")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, this patch and "EVM: Fix null dereference on xattr when xattr
fails to allocate" are queued in the next-integrity branch.

Mimi

> ---
>  security/integrity/evm/evm_secfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
> index a7a0a1acae99..fb8bc950aceb 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -158,6 +158,8 @@ static ssize_t evm_read_xattrs(struct file *filp, char __user *buf,
>  	mutex_unlock(&xattr_list_mutex);
>  	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
> 
> +	kfree(temp);
> +
>  	return rc;
>  }
> 

