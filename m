Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AH8x225y+mBaMUAEN05yVHICupWeAPvBuZ/AyNx8K3P83vlhK1jmvEYgQb3Em5Y4V7qxZISpydKj
ARC-Seal: i=1; a=rsa-sha256; t=1518786753; cv=none;
        d=google.com; s=arc-20160816;
        b=eptv6w6YlIr+LE8whBtF9eTePyCd6n1ZTbHYxJCPlT56Y2XiF9VfwcCg0uaeaChEKy
         hSIZXM/k5AOjOP54sBeGUU+C9xaNTNWakdH5Qsk4dMMPyi9HCXtxQU9OrBdTheOr4dWf
         Uctxkt/nrelmtf1+eK6aGFZoIh51tIJah1PJF/r9LD79DE+IAvSaIxvbqGj86LunnHY7
         H5ExuxHbmWf2uDE4u5fvUcFofLZDhfer3uMjlxYIi2UD+UkCFzLEu2fA2U2yZRR5pEan
         SmJltwC+VB2y8HdsSDKNwj7wy1tO/toh+MHReVlH9bcD73r1hIG+9voCY8c6B64ekJBO
         L9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=4+6hGbUzYFVfF7vz39eWL0A/lMRgu3waeO2WPXN5Agw=;
        b=lUvqBC2rC8i2oohUkd+wl7B3ynBZBjBjS91lAtB079Tb70xTrkx2yTFzrYCmnaXXXC
         ega6XGXeDpc5dw7hU5mtWzDJQzb/8eAK1aGQwNKM5rK7y8WwdeDUnwCGF5qnLaowMMaV
         wCOUBA6qQvshgbx7BaPTiEAgAP8KqGCnlYowuIwt8Hmw6sQOU2p099EUorAqgiAaT4u+
         omBzUbfFL3KIT5DlMVohd9AMxC61RPkhNMver43Wbl+A/B1xDvVu/8ATYItWsFl5R3LA
         LEmvhvPHpHm4HRFL459OztAtdifIa8AEs3hUsX9JnUWgM1encFhYYEngctP//WgGkxlv
         bbCg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=kOUunR6H;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=kOUunR6H;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
MIME-Version: 1.0
In-Reply-To: <20180216092959.gkm6d4j2zplk724r@gmail.com>
References: <20180215165920.8570-1-pasha.tatashin@oracle.com>
 <20180215165920.8570-7-pasha.tatashin@oracle.com> <20180216092959.gkm6d4j2zplk724r@gmail.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 16 Feb 2018 08:12:31 -0500
X-Gmail-Original-Message-ID: <CAOAebxuFivBx+6kexgV0JRtdxi+j9qy-hReMPsYk8NmzaKUNkQ@mail.gmail.com>
Message-ID: <CAOAebxuFivBx+6kexgV0JRtdxi+j9qy-hReMPsYk8NmzaKUNkQ@mail.gmail.com>
Subject: Re: [v4 6/6] mm/memory_hotplug: optimize memory hotplug
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
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=308
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802160159
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315446931456044?=
X-GMAIL-MSGID: =?utf-8?q?1592563339035999057?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>
>   Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thank you for your review! I will address all of your comments in the
next patch iteration.

Pavel
