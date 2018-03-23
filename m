Return-Path: <blackzert@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521825918; cv=none;
        d=google.com; s=arc-20160816;
        b=wC4kxbvLh4MtGU+gVsSZewWpGrOLipMJHrRuJER3U8TbfAFzdJjX0c9kOHSanRZtqs
         TN2Kw2KKqUHp9xOJCNA7UDow5UDgaH5/Wom6hy3xrhFrbzxKo3XSpQLtur1OQupdRR7w
         pUTxDzB0RqWq6aiMtIZMIDy06gTwf/hzgY7+GFpPULBnMfDeRQO3FleoDJVruVMcRbIV
         FB93Xh8RvyjXMYVIhAKNN0tXDDR0It9OE1nk88SeuGDpv2baJ+BNdcO5sVhqvwQi3Mfc
         i8ok3SdKm1zyA5erFsVF6YhHFTm6mS6nI5AZjx0ZxETSikq4NHiCn/bArD9fpw688Hqq
         LqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=+OZYzmT42h5SnWF0OczzPVpdipxT1C1TADxUtBA1ByE=;
        b=tsI8GBDEnXWCVIl6sDsWc/LLfrMas0ANnP5ErG8KkFWGurVjQlcOgZH2uWjFSJx/QS
         v5gCufqVeNs4/fRKCgfcFN363pMTI4agyoatmhxat8T4HDspYCT5O31JXzdS3VM5giFx
         OUZWTUsqaMCXbgcUaDOzCwRiEm65C2o7mF8NeBj9MK8Y++06rHLsSS/nYLce2/sR/9Sa
         MaGRzMSgu95V5ayfiTaGF+K/jLKw57TwbYYNwC+/WHgPmKiRw/cyD85R20JB+eljxw8O
         obEbPnOQ6H4cZjiOtBRbaoaEM+c5/uhh67fQFvLl6G2DjtY8/q0Qc/lqT9UJfkndAKqs
         +e5g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OMlmcj8c;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OMlmcj8c;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELs5zcJhgSg9vwDza07EaDR0FQ17bw+vBwBGrJupYOX3TXXRodca/W9uPN4u58MIyJuxfBeFnQ==
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
From: Ilya Smith <blackzert@gmail.com>
In-Reply-To: <20180322135729.dbfd3575819c92c0f88c5c21@linux-foundation.org>
Date: Fri, 23 Mar 2018 20:25:15 +0300
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
Message-Id: <C43F853F-6B54-42DF-AEF2-64B22DAB8A1D@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180322135729.dbfd3575819c92c0f88c5c21@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1595750134334041968?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello, Andrew

Thanks for reading this patch.

> On 22 Mar 2018, at 23:57, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Thu, 22 Mar 2018 19:36:36 +0300 Ilya Smith <blackzert@gmail.com> =
wrote:
>=20
>> Current implementation doesn't randomize address returned by mmap.
>> All the entropy ends with choosing mmap_base_addr at the process
>> creation. After that mmap build very predictable layout of address
>> space. It allows to bypass ASLR in many cases.
>=20
> Perhaps some more effort on the problem description would help.  *Are*
> people predicting layouts at present?  What problems does this cause?=20=

> How are they doing this and are there other approaches to solving the
> problem?
>=20
Sorry, I=E2=80=99ve lost it in first version. In short - memory layout =
could be easily=20
repaired by single leakage. Also any Out of Bounds error may easily be=20=

exploited according to current implementation. All because mmap choose =
address=20
just before previously allocated segment. You can read more about it =
here:=20
http://www.openwall.com/lists/oss-security/2018/02/27/5
Some test are available here https://github.com/blackzert/aslur.=20
To solve the problem Kernel should randomize address on any mmap so
attacker could never easily gain needed addresses.

> Mainly: what value does this patchset have to our users?  This reader
> is unable to determine that from the information which you have
> provided.  Full details, please.

The value of this patch is to decrease successful rate of exploitation
vulnerable applications.These could be either remote or local vectors.
