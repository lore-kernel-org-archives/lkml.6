Return-Path: <blackzert@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522400882; cv=none;
        d=google.com; s=arc-20160816;
        b=daklbdHI4FmcJTU7HIUgr47dTOPjcEVgIxbFgMe1hpeDc3g3taQH1p/qAd4EVFpHxx
         Otx9HOjWCWtX4zPzOJdhC/CYCj/OP8TP94We8n5sxiwXxZlL2vJYtyMFpsrMmt7lXaWL
         puMK6AO0slVhE0Ht2kQjH9HwWGstTP4aqPCTSjC/9tjwpk6qeEgly51Wwe8QKPlGAV2K
         1mERsesgYKJMIDZrDEsXxeTJMVyjZCh4Y7qCDcu5z56vxa0uXE87k4tk/U33LhfI1VlM
         /FxiY4RyR8ktrmdDOrBfXZ89PyygbF7jIFbwCirosQ1bEiXuzFV/XT2SK6a1rxQLG59I
         uFgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=ZTjxoqKaoobJFUevSLgPJQU741b1iW8H0MvOHx0z9s8=;
        b=hALKtA3Vz52npFGMO3rnjgQ2v/sGi4sN6+EEA2A7B3Bf4RxLyzHMdvAWnjh0TbZslg
         iIHpKBQktduZ8t2n9jO4E+Lro88MR8y0jHEEwI/D1xO8ymnkve1IJTl1BYPTikXvjlW+
         sfy4j5qNAvUIFjEaT2xkGPFuutTq0fEWkIjhiBT3pRbkrsIuqA5Te5O0ydXNa5Q7Sp7d
         XCw99h+vaCIqA5HXg5art1gmAoSXWGCLpIwe/1tVRjzvIU5kpSPKD/27cP2EHNAa5b1v
         ymBOp5jE1WczfGCK7BsNmkL5RVxjss3qMq1GhXWzucXbG6kgeO2rdb6PTgozXJbdkUoR
         SUTA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RouoAPah;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RouoAPah;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4819IvCDJg/mTs2Ax4OcWGaODCSYvKwRadsg1AoBjgPwzfi7Txju4VQpU86PWklyO824cjPiA==
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
From: Ilya Smith <blackzert@gmail.com>
In-Reply-To: <20180330075508.GA21798@amd>
Date: Fri, 30 Mar 2018 12:07:58 +0300
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
 Helge Deller <deller@gmx.de>,
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
 Michal Hocko <mhocko@suse.com>,
 hughd@google.com,
 kstewart@linuxfoundation.org,
 pombredanne@nexb.com,
 akpm@linux-foundation.org,
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
Message-Id: <95EECC28-7349-4FB4-88BF-26E4CF087A0B@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180330075508.GA21798@amd>
To: Pavel Machek <pavel@ucw.cz>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1596353027728016155?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi

> On 30 Mar 2018, at 10:55, Pavel Machek <pavel@ucw.cz> wrote:
>=20
> Hi!
>=20
>> Current implementation doesn't randomize address returned by mmap.
>> All the entropy ends with choosing mmap_base_addr at the process
>> creation. After that mmap build very predictable layout of address
>> space. It allows to bypass ASLR in many cases. This patch make
>> randomization of address on any mmap call.
>=20
> How will this interact with people debugging their application, and
> getting different behaviours based on memory layout?
>=20
> strace, strace again, get different results?
>=20

Honestly I=E2=80=99m confused about your question. If the only one way =
for debugging=20
application is to use predictable mmap behaviour, then something went =
wrong in=20
this live and we should stop using computers at all.

Thanks,
Ilya
