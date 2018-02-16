Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AH8x225M8l6dcG1m3Z+UPR4gKnBQ5sRLeOoHvDgIef9Czn1ogLIamT/XHKgekEX4cqggcqmBh6kH
ARC-Seal: i=1; a=rsa-sha256; t=1518786450; cv=none;
        d=google.com; s=arc-20160816;
        b=D7KmvAtIz/R0PT7vHtxFaVQ61Y6Z6JlQUpKMXcDNED+SxrqByw3hSsOh2PX1c3hilG
         0m/8Tfy7klLoFX5xsDXaatptamj4AMPaqhhMp67bGYWuZ2hCaJQMoB4QTL/hS1WNdSnG
         I3kHvWZ454fe9DDe3je3ZyiNZottKXohHxZAAMnAaxMTlrnqA+b4O4aB0i6HepPcXbwV
         n0s6aB2zCWfhK+OESP5ULg0NLXzpg3774mwQ7eSvTGjoGahzptGHT2I90ylg1ebFC/+Q
         gFr448SCwt6xtUiDmiRjyRRlxCvYsqYtwh82qG0PoKy/QLAypWwVws0Ibv9s/Ypo3GcZ
         YqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=hJcxbjRnUHCm+nQGhS5JvMiIguwF9V7DqwQvrkwKEaw=;
        b=qW2lLuVPC1TZMdgnwVIGl3V3U6VIK49RHXE10xSTe932AFv/p9yrv4XIICDKJ3g3sc
         fL8QdHqqWI5fizilF/PmdUVe6zrxrzXUs5nSjxJwztXkuvtkOhx+lMJoPd750p8x0VoF
         pgeXaoRlfc3kX55V4fTjqIiz2Si9dZ3fEiSrHwE44nufWf442opdqk2C6zKvoRwSdbHu
         CNw+umUL1qpG3zO2B84CJ5FsBpMeH5JDDYCp9R4pVuq+jSfSh1YJrL1vdR22TeYf2VEK
         Eb3wSZhLaf/bUvRyx1vKdHr4RIQ+DcpPNkqksLy4agEQbxjvhVsP2EpP0VnDWP91zQpl
         dq3w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ZEEp/A8e;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ZEEp/A8e;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
MIME-Version: 1.0
In-Reply-To: <20180216091304.hgp5tn25nleuy4jc@gmail.com>
References: <20180215165920.8570-1-pasha.tatashin@oracle.com>
 <20180215165920.8570-5-pasha.tatashin@oracle.com> <20180216091304.hgp5tn25nleuy4jc@gmail.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 16 Feb 2018 08:07:26 -0500
X-Gmail-Original-Message-ID: <CAOAebxvwaHT8fQ+FnJYi90ogZtJ1wpRqvXYfx=KPsiX_gVp9tA@mail.gmail.com>
Message-ID: <CAOAebxvwaHT8fQ+FnJYi90ogZtJ1wpRqvXYfx=KPsiX_gVp9tA@mail.gmail.com>
Subject: Re: [v4 4/6] mm/memory_hotplug: optimize probe routine
To: Ingo Molnar <mingo@kernel.org>
Cc: Steve Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, dan.j.williams@intel.com,
        kirill.shutemov@linux.intel.com, bhe@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8806 signatures=668672
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=453
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802160158
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592487036268722701?=
X-GMAIL-MSGID: =?utf-8?q?1592563021094155709?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thank you!
