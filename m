Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3422286-1525396828-2-6485711735361187296
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525396828; b=E45KxuTqtiBt/6bYNhkbYhukmQj9jvt5PYSub8jcW34xQu0O0g
    2ZxWyBB1l7BI7uYOviVjb5RxavBXp3gzFIdedCi7Hk9RBwiOY6frUFk/ajOEnaot
    cM5IHVnztX6Y4v9pWI3W2NXKHJmrWZQVcGxYqjyrgR5P2mwA6YkJvpD05HlxRNxi
    LK34m72BcdLI1GwRI5TjntIxE00Ha+2S1IVn1GJ4MwPiZretnrmnBcFu4edBRvZ4
    bU+T2reAR4GML1K2e0J8ZJM4zGNcOHoq5VP2qHOiWGmp/R1mdpBsLawavhWVBuvP
    /B5jC6vJmINgjTXrxg0ExWGoAmMaS4RvhH5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:references:to
    :message-id:sender:list-id; s=fm2; t=1525396828; bh=Ak/qcxhwE14e
    5zJvAdQZDlU5CGtdWmvYInjfg3Z13CU=; b=jHJPjFBDafDSV0zMeaeYlXHq4rFL
    9vDqPqXlncck0qJpsssstvreOnk9nY+7AeX+tIk8YFR0Fy7Etd1RKG2OSPVlTCV1
    sZVW9PMpfuknwnSRL11xyLyiS2vssKMWrZv3lxMKSi/FRLJDmGDPlzOa0hIPnEXI
    K7gaY8HSmih98YtP4/KbrjWkClV7jzxwcuLsEkidgK3c8gTmk8j72QkJkX57v6Ez
    C/5rBEXn6J7VvR/+cPOqtVWeSfjXKqWF0bNrCgYAgm3cVetBMLlJnvCZZYxNz5Ji
    t43XDq9CbaC8UAT2A18vrTD+QwSQc5iQ8Q2oFA94GKsMMVGbbvSiY5BpPw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKi8GOTF3qKYKaB7qfmP1pXDzvYmlqWSSZ1Vl4vGMKdtvTu15cFgPY6tOhdvkw8sTSRsyeHFZOWTf8Wwz8UU5wJ1el5/aqef8mMa9BlD2OmRUlZjepC5
    svtBF/BYDOsTWTJa/+OkD1SE7BpXsiS1a6/iU6rL8L7qzF1HwDm67UPVMI9o5y2CfhaKujJXEsn0bAOSl6wKatbzjqt38SG5vpJdMGls3vnXsOqId2IMVXlL
    dbBDjReY0PumUyuHiTNZzQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=jlY5g9R6hR36p1gyXV8A:9
    a=VFAflaYM64q-Nwar:21 a=wyxssFzoII3yipSt:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeEDBUY convert rfc822-to-8bit (ORCPT
        <rfc822;linux@kroah.com>); Thu, 3 May 2018 21:20:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751420AbeEDBUW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 May 2018 21:20:22 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v6 0/4] Certificate insertion support for x86 bzImages
From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
In-Reply-To: <1525383720.3539.76.camel@linux.vnet.ibm.com>
Date: Thu, 3 May 2018 21:20:16 -0400
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Keyrings <keyrings@vger.kernel.org>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Linux Security <linux-security-module@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        George Wilson <gcwilson@us.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Patrick Callaghan <patrickc@us.ibm.com>
Content-Transfer-Encoding: 8BIT
References: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
 <alpine.LRH.2.21.1805040311050.12843@namei.org>
 <1525383720.3539.76.camel@linux.vnet.ibm.com>
To: James Morris <jmorris@namei.org>
X-Mailer: Apple Mail (2.3445.6.18)
X-TM-AS-GCONF: 00
x-cbid: 18050401-0008-0000-0000-00000302904A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008965; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01027141; UDB=6.00524651; IPR=6.00806274;
 MB=3.00020917; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-04 01:20:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050401-0009-0000-0000-000039203FCF
Message-Id: <04EE0041-8DF1-4FF3-9C59-64ECF0182CC5@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805040011
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> On May 3, 2018, at 5:42 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> On Fri, 2018-05-04 at 03:11 +1000, James Morris wrote:
>> On Wed, 2 May 2018, Mehmet Kayaalp wrote:
>> 
>>> These patches add support for modifying the reserved space for extra
>>> certificates in a compressed bzImage in x86. This allows separating the
>>> system keyring certificate from the kernel build process. After the kernel
>>> image is distributed, the insert-sys-cert script can be used to insert the
>>> certificate for x86.
>> 
>> Can you provide more explanation of how this is useful and who would use 
>> it?
> 
> I'm involved in a number projects that rely on a kernel build group to
> actually build kernels for their systems.  Reserving memory for
> additional public keys, allows product groups to insert public keys
> post build.  Initially the product groups might insert development
> keys, but eventually they would insert the product's public key.
> 
> Mimi

With CONFIG_SYSTEM_TRUSTED_KEYRING, we have a system keyring populated
with keys that we trust. Initial keys are compiled-in:
-The module signing key, as specified by CONFIG_MODULE_SIG_KEY,
-Additional keys, as specified by CONFIG_SYSTEM_TRUSTED_KEYS.

In userspace, we can add more keys to the system keyring, only if they can be
verified by keys already in the keyring.

In kernel or modules, we can bypass this restriction by using the
KEY_ALLOC_BYPASS_RESTRICTION flag. As far as I can tell, only the compiled-in
keys are loaded this way in the upstream kernel.

Other asymmetric keyrings can specify the same restriction using the
"builtin_trusted" option. Currently, CONFIG_INTEGRITY_TRUSTED_KEYRING creates
".ima" and ".evm" keyrings with this restriction. As a result, in order to
add a key to an integrity keyring, either that key needs to be compiled-in,
or it must be signed with a key that is in the system keyring, which again
needs to be compiled-in.

If a user is not compiling their own kernel, and has no access to the module
signing key (or any other compiled-in key), then how can they add their own
keys to the integrity keyrings?

This patchset allows the user to take the kernel from a distro, insert their 
own key, sign the resulting image as required for their secure boot method,  
and when booted, the system keyring will include their key, which can be used 
to control the integrity keys.

An alternative way is to allow the "secondary" trusted keyring to verify the 
IMA keys with CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY, but 
it is the same problem. Some distros carry patches that populate the 
secondary keyring with UEFI keys during kernel initialization, which would 
mean having access to a UEFI key (which is also needed with this patchset, 
for signing the resulting image), would be enough to add integrity keys. But 
that is much more permissive, since ANY key that goes into the secondary 
keyring, coming from UEFI, could then be used to control the integrity keys. 

Mehmet

