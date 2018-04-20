Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-990390-1524210864-2-12221484691414276457
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524210864; b=vJVWo+lF+3GAc24pC7gxqbKZlCtM918qSzuYM589SsNMGa7oph
    xmmrXe0lFOc97PoKY8lkgFITetpUZZg2kTgYmqEmalE/PG3Edqa24LxoA0vbo0mY
    /DN/ZdGXIK9O6Sgv0xKx0zSi6S3AmI17g2CoLEXdCDuyl/wej/mYEutF8jdN7waQ
    QLLj4yy5IsTrLBRg7iDe2arUhC7kYxMcOTtiOe4DKxInZz6iYlrgmtBcgEPcesqM
    1nT30n77s6tcdb0yBxMoEJEhOsXiTgvP1QAFl/L7+htxWrLTvuFiklkP6sAInQJH
    9/ReUm3JNpNS9EX/ZeWUTPbbeLt6BTzIcB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:references
    :mime-version:content-type:in-reply-to:message-id:sender
    :list-id; s=fm2; t=1524210864; bh=D8rNWSvym7J9FOt7GwjSMzMH/MFi/b
    Gt6U8AHGdYjoM=; b=mmeQEJdVUVsojCmC8XkRJwalo5c1ulB81XF1l/7xYF/sOP
    nW3yVVVlxuE0meyn2bmFaeyqV8wQe9Wsg8ljlNvClQrzsTA98Y2qey71WvO0wed9
    dl0QEGFg5cq3fVFKPRtMtTRoBdYo7n561Hg4GRQVeXCCjPMz+++FVnDHZ7THlBaC
    sN8D/ToCPYwslZDeXY+0BK/2vqbgd3PBFMyKkxhBuvFxpAsNCe6SdB+c0POXeeO3
    8zZ+fDZ/zm095V8hiGjErENPvYD/2UbjlfJYHTsrX2bt3CkEtR24zayiyQV1OLOH
    X8lyh9L0aKWq/xpkIItEcyQ0XCHODl1nYeO3bJ9A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=de.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=de.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=de.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=de.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKyvcKgy4RNWuYaJITuuLzuL+hXSLbCXck2sGbSfOAyWCBQXIYqg2RxjFurIWSh+0SWqEN1DZqo8ULWODBbWNAEtqiAdfveUtI4zoRUBstbpPArQNLQ0
    mjc0M64/AGi+07y8/3bBnm0QfGqQFjV9fyrd4w4VSw3gsVOgW+hV0vKFsSegWP9S8pRyQz6DJgstgawTXKdax61KnShZGFvSR/qrInwvXTnunNroPXvtI14/
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=hsoxY6qMgJ34QE3A0z0A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753849AbeDTHyV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 03:54:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753854AbeDTHyT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Apr 2018 03:54:19 -0400
Date: Fri, 20 Apr 2018 09:54:07 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        libc-alpha@sourceware.org, tglx@linutronix.de,
        deepa.kernel@gmail.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, albert.aribaud@3adev.fr,
        linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, x86@kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-mips@linux-mips.org, jhogan@kernel.org, ralf@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 04/17] y2038: s390: Remove unneeded ipc uapi header
 files
References: <20180419143737.606138-1-arnd@arndb.de>
 <20180419143737.606138-5-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419143737.606138-5-arnd@arndb.de>
X-TM-AS-GCONF: 00
x-cbid: 18042007-0044-0000-0000-0000054A493A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042007-0045-0000-0000-0000288A6979
Message-Id: <20180420075407.GA7119@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804200079
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 04:37:24PM +0200, Arnd Bergmann wrote:
> The s390 msgbuf/sembuf/shmbuf header files are all identical to the
> version from asm-generic.
> 
> This patch removes the files and replaces them with 'generic-y'
> statements, to avoid having to modify each copy when we extend sysvipc
> to deal with 64-bit time_t in 32-bit user space.
> 
> Note that unlike alpha and ia64, the ipcbuf.h header file is slightly
> different here, so I'm leaving the private copy.
> 
> To deal with 32-bit compat tasks, we also have to adapt the definitions
> of compat_{shm,sem,msg}id_ds to match the changes to the respective
> asm-generic files.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/include/asm/compat.h      | 32 ++++++++++++------------
>  arch/s390/include/uapi/asm/Kbuild   |  3 +++
>  arch/s390/include/uapi/asm/msgbuf.h | 38 ----------------------------
>  arch/s390/include/uapi/asm/sembuf.h | 30 -----------------------
>  arch/s390/include/uapi/asm/shmbuf.h | 49 -------------------------------------
>  5 files changed, 19 insertions(+), 133 deletions(-)
>  delete mode 100644 arch/s390/include/uapi/asm/msgbuf.h
>  delete mode 100644 arch/s390/include/uapi/asm/sembuf.h
>  delete mode 100644 arch/s390/include/uapi/asm/shmbuf.h

FWIW,

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

