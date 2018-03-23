Return-Path: <blackzert@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521827346; cv=none;
        d=google.com; s=arc-20160816;
        b=JeeFGaOprqApt/WtqnnRsKFun/O9APMg9B1WWnRpiM0VEbNJ9X5SBEMJj4eh8wgpe0
         0sHtVHSuy6CYFfnf3mtogtf3m72QwFD2KMz/K7WhCYFLtIgAB9BjxFji9O5kB6ekz19y
         A1/IhsmDizwC96hkN6YtsNDfxRrEm57+aBac1Rx8uhuEZbVffPf5UQ9gsSaMJf9FkqhT
         tQ69mLL6RVi+o+/yfAiNEMEihsCdWz8ELwI/lwnfXCqv1/ECI3bWuu/4e1VjyNKWC62c
         ggslociYk/jxUGlwWQ+3VZINFP/9aFc9a0Tpmaikx5ZJB2jMIF2Oiiaph78/X1ig5sK0
         dojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=jQmHZjnJbgzm5Bnta7AxMgcjy2Bp3CXXFf+gGk9Ctfs=;
        b=CO+OT+RvMy7k9KiUoA932qilqjInumGRapTtlyJxuQM0upXhrir7xqdxsd3nvu8DLl
         yfRNeA1IH28GTIFO8C45EQiZf7KDf6yoMJ8RWDAvg5jcC7KR69eoHaRdtKiBbviBNNet
         YFbWIwf2hStRFJlIS+lCAlB2azN0pXIPKvsfvNMmQuiG+Jl1pt1SBZ7Ry9n3zGA7kInE
         fFQkZRmUwRAIVx6PZTaSHwZxvDu11kKGU7lhr6apgma4Bwf/j1dU/E6xIsBTprYLQ95N
         8b9xORT3+2A/rbDUujBDfGJiNhaExbEZGeYfGWzCSqEcjutnI58XSpPQofLKoMc7szDQ
         5Ugg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=egpWFPxz;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=egpWFPxz;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuRtAiE5GxJ4PVlasYQbBVUoZzWlqey9KsMKVVJwaWDGj31q8vofooz0Xfhmk8aYru+zAB7Aw==
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 2/2] Architecture defined limit on memory region
 random shift.
From: Ilya Smith <blackzert@gmail.com>
In-Reply-To: <20180322135448.046ada120ecd1ab3dd8f94aa@linux-foundation.org>
Date: Fri, 23 Mar 2018 20:49:03 +0300
Cc: rth@twiddle.net,
 ink@jurassic.park.msu.ru,
 mattst88@gmail.com,
 vgupta@synopsys.com,
 linux@armlinux.org.uk,
 tony.luck@intel.com,
 fenghua.yu@intel.com,
 jhogan@kernel.org,
 ralf@linux-mips.org,
 jejb@parisc-linux.org,
 deller@gmx.de,
 benh@kernel.crashing.org,
 paulus@samba.org,
 mpe@ellerman.id.au,
 schwidefsky@de.ibm.com,
 heiko.carstens@de.ibm.com,
 ysato@users.sourceforge.jp,
 dalias@libc.org,
 davem@davemloft.net,
 tglx@linutronix.de,
 mingo@redhat.com,
 hpa@zytor.com,
 x86@kernel.org,
 nyc@holomorphy.com,
 viro@zeniv.linux.org.uk,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 deepa.kernel@gmail.com,
 mhocko@suse.com,
 hughd@google.com,
 kstewart@linuxfoundation.org,
 pombredanne@nexb.com,
 steve.capper@arm.com,
 punit.agrawal@arm.com,
 paul.burton@mips.com,
 aneesh.kumar@linux.vnet.ibm.com,
 npiggin@gmail.com,
 keescook@chromium.org,
 bhsharma@redhat.com,
 riel@redhat.com,
 nitin.m.gupta@oracle.com,
 kirill.shutemov@linux.intel.com,
 dan.j.williams@intel.com,
 jack@suse.cz,
 ross.zwisler@linux.intel.com,
 jglisse@redhat.com,
 willy@infradead.org,
 aarcange@redhat.com,
 oleg@redhat.com,
 linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org,
 linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <548B6BB8-FD6F-4F8D-B67F-2809305C617D@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <1521736598-12812-3-git-send-email-blackzert@gmail.com>
 <20180322135448.046ada120ecd1ab3dd8f94aa@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656493467338178?=
X-GMAIL-MSGID: =?utf-8?q?1595751631673538172?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> On 22 Mar 2018, at 23:54, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
>=20
> Please add changelogs.  An explanation of what a "limit on memory
> region random shift" is would be nice ;) Why does it exist, why are we
> doing this, etc.  Surely there's something to be said - at present =
this
> is just a lump of random code?
>=20
>=20
>=20
Sorry, my bad. The main idea of this limit is to decrease possible =
memory=20
fragmentation. This is not so big problem on 64bit process, but really =
big for=20
32 bit processes since may cause failure memory allocation. To control =
memory=20
fragmentation and protect 32 bit systems (or architectures) this limit =
was=20
introduce by this patch. It could be also moved to CONFIG_ as well.=
