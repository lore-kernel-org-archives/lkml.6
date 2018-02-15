Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AH8x227w60fWTqSqWjOl7+t9QK0btej8DtbztJ75oYttYnT4HJWGFHQTUag7JdLzVATUiiJgKg3K
ARC-Seal: i=1; a=rsa-sha256; t=1518701991; cv=none;
        d=google.com; s=arc-20160816;
        b=Zaasl2aI+9ZaRLlA72VIbhkbrG2A2U8XA1oU4OTXY9hutq27mO8lQ4a0QNfG4br3aq
         lQMgbXvzwXEhxkfiier+7fgGddZX57pN3mw0vaekwAl50JoWHFCfHPiZIz+4DYBZ5U5L
         +sTY8tvYVMVLUHkoH65fi1ULsuOA8rjODIS7uRMDeVAX/oUFUC+t5cp8Wm1VzHaGCKLB
         q2PN8lC13nJ2ERGyWlOZSJq74LE4ZFYKMLX3fz8ChQ+ldaL2JbHMZga2qhDcoqA35E8L
         ZbmYMUvr9GT6bCYkh2wEZ9JOY/nTnjcViRs2YgeCNnskGPQED0ry4jk0950lusOydu+g
         2XDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=vQRTxFLk7M0oFGEXFAHavydgp3RZp6IoV1WjPynfKv4=;
        b=GTyCyDLLjSV6YDoHtEHNDwBRSj48Zo9EY0saCD1j4unpydgRrsmUyeCjoaPvrJDjz8
         R6pocipzNDBD5eqB6+RZ4EM/a20EziIvxfc4IK36OOOcRV7C6hT+POGxJMEaZqr7iB9v
         mosjHcXvr9qKVQuoljtj9F3s5FmNWtTNtCDIq1orRbP43ROdJ8HauBArAztjyvE5tzpN
         8vYf8TNS9g4oIcAFc5lRRZEvFKkyj4hoxQp/f6oi1sJbq22PcXKWb6N1MXasV2GeqpaM
         ISjr0lqvFX/29g3vrcSQ9pXgUvj3KeSvUiHZmqQmmbIgZAwsUla206KfRXluwOjN2f+Z
         2Qnw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=rJgz+3Og;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=rJgz+3Og;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
MIME-Version: 1.0
In-Reply-To: <20180215113725.GC7275@dhcp22.suse.cz>
References: <20180213193159.14606-1-pasha.tatashin@oracle.com>
 <20180213193159.14606-3-pasha.tatashin@oracle.com> <20180215113725.GC7275@dhcp22.suse.cz>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 15 Feb 2018 08:39:47 -0500
X-Gmail-Original-Message-ID: <CAOAebxu5EM1qhC=pS2cCqjGfBabFEj0aQQNon1nAz5_3YPOsCw@mail.gmail.com>
Message-ID: <CAOAebxu5EM1qhC=pS2cCqjGfBabFEj0aQQNon1nAz5_3YPOsCw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] x86/mm/memory_hotplug: determine block size based
 on the end of boot memory
To: Michal Hocko <mhocko@kernel.org>
Cc: Steve Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, dan.j.williams@intel.com,
        kirill.shutemov@linux.intel.com, bhe@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8805 signatures=668671
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=699
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802150170
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315446070110278?=
X-GMAIL-MSGID: =?utf-8?q?1592474459033543975?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> I dunno. If x86 maintainers are OK with this then why not, but I do not
> like how this is x86 specific. I would much rather address this by
> making the memblock user interface more sane.
>

Hi Michal,

Ingo Molnar reviewed this patch, and Okayed it.

Thank you,
Pavel
