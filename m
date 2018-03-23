Return-Path: <blackzert@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521827008; cv=none;
        d=google.com; s=arc-20160816;
        b=drIxx3zMsV6uhSNXIBquMSLi+KY7qEBsELILxbifoELjlVAltQaWaexsd5kFJ3j2NH
         0IE9aQeghwWw7wpGVbSQlK8RKRN9UN/om7zh8zSVqbUbeGm6ZDGDpAqQTr8TT6pEQKtL
         H/aAao/DEqe11AzBIsff2kNmC7l5VbTo3BIK0ijQSJSuOT3EpMocODVDGY8AtLqs3qmV
         SILH4nZXOuWztpgCoUqanqOZcQ8eaK+sBlcfsFgc+ZD9HiPyGddFkuZ6Dyuubmnb7a2g
         oYpIK1vTh6J26KDnbOk8eEANt3jq4rIjQvBoW1MmpXRrxQ/Hbw+khLeg/yOP6E4sLypo
         pFkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=QZq4UFrT02MMmDvS3rVa2L5oKghNblZL+cJZh/o9UH0=;
        b=I6UBo+yJAVoJ3Oo4izb5dr25jI6+j64Ta4e8BgnVtr+9IhD7aenVIIKBxtu3Loj/Xq
         G0p+0WjfCrTZW+TK1k8CKuqQKekliZpF82GMqdiH+XOyAp6Vu9F94LlUuwpoq4BaxlhN
         rnTVslDiBg95fxSu+8DT02dyWc6yctLXzM/93rBlj8+LsraJbyQAB8wphby2KeTkdPZl
         zdYGkv/9d8zJVYWe3QwvZaOdt/4mcwMf0nhJZYtJcom0pN8jstaVnSmCEovcn5Z+kbJc
         D3zjTXh45tZZcgB/bSh3VJjBYdAlBhZyn7gB+jQl0mnbzjWJPpFKl/xBDAxNkLVg+geF
         MJZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JHbHee0h;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JHbHee0h;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsm3SSvZMKhrtdKOCSDDRM/445Cf1QIFUfL/ApGlTQAxukWZUdRrtOYDTWVnwvMSsy++jwWiQ==
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 1/2] Randomization of address chosen by mmap.
From: Ilya Smith <blackzert@gmail.com>
In-Reply-To: <20180322135314.61efce938293e051e118fa46@linux-foundation.org>
Date: Fri, 23 Mar 2018 20:43:25 +0300
Cc: rth@twiddle.net,
 ink@jurassic.park.msu.ru,
 mattst88@gmail.com,
 vgupta@synopsys.com,
 linux@armlinux.org.uk,
 tony.luck@intel.com,
 fenghua.yu@intel.com,
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
 Hugh Dickins <hughd@google.com>,
 kstewart@linuxfoundation.org,
 pombredanne@nexb.com,
 steve.capper@arm.com,
 punit.agrawal@arm.com,
 aneesh.kumar@linux.vnet.ibm.com,
 npiggin@gmail.com,
 Kees Cook <keescook@chromium.org>,
 bhsharma@redhat.com,
 riel@redhat.com,
 nitin.m.gupta@oracle.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jan Kara <jack@suse.cz>,
 ross.zwisler@linux.intel.com,
 Jerome Glisse <jglisse@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Oleg Nesterov <oleg@redhat.com>,
 linux-alpha@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 linux-snps-arc@lists.infradead.org,
 linux-ia64@vger.kernel.org,
 linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org,
 Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <547032AD-605D-46AF-9DA6-C2ECA01923E1@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <1521736598-12812-2-git-send-email-blackzert@gmail.com>
 <20180322135314.61efce938293e051e118fa46@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1595751277360788261?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> On 22 Mar 2018, at 23:53, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Thu, 22 Mar 2018 19:36:37 +0300 Ilya Smith <blackzert@gmail.com> =
wrote:
>=20
>> include/linux/mm.h |  16 ++++--
>> mm/mmap.c          | 164 =
+++++++++++++++++++++++++++++++++++++++++++++++++++++
>=20
> You'll be wanting to update the documentation.=20
> Documentation/sysctl/kernel.txt and
> Documentation/admin-guide/kernel-parameters.txt.
>=20

Sure, thanks for pointing there. I will add few lines there after =
discussion them
here.

>> ...
>>=20
>> @@ -2268,6 +2276,9 @@ extern unsigned long =
unmapped_area_topdown(struct vm_unmapped_area_info *info);
>> static inline unsigned long
>> vm_unmapped_area(struct vm_unmapped_area_info *info)
>> {
>> +	/* How about 32 bit process?? */
>> +	if ((current->flags & PF_RANDOMIZE) && randomize_va_space > 3)
>> +		return unmapped_area_random(info);
>=20
> The handling of randomize_va_space is peculiar.  Rather than being a
> bitfield which independently selects different modes, it is treated as
> a scalar: the larger the value, the more stuff we randomize.
>=20
> I can see the sense in that (and I wonder what randomize_va_space=3D5
> will do).  But it is...  odd.
>=20
> Why did you select randomize_va_space=3D4 for this?  Is there a mode 3
> already and we forgot to document it?  Or did you leave a gap for
> something?  If the former, please feel free to fix the documentation
> (in a separate, preceding patch) while you're in there ;)
>=20

Yes, I was not sure about correct value so leaved some gap for future. =
Also
according to current implementation this value used like a scalar. But =
I=E2=80=99m
agree bitfield looks more flexible for the future. I think right now I =
can leave
3 as value for my patch and it could be fixed any time in the future. =
What
do you think about it?

>> 	if (info->flags & VM_UNMAPPED_AREA_TOPDOWN)
>> 		return unmapped_area_topdown(info);
>> 	else
>> @@ -2529,11 +2540,6 @@ int drop_caches_sysctl_handler(struct =
ctl_table *, int,
>> void drop_slab(void);
>> void drop_slab_node(int nid);
>>=20
>>=20
>> ...
>>=20
>> @@ -1780,6 +1781,169 @@ unsigned long mmap_region(struct file *file, =
unsigned long addr,
>> 	return error;
>> }
>>=20
>> +unsigned long unmapped_area_random(struct vm_unmapped_area_info =
*info)
>> +{
>=20
> This function is just dead code if CONFIG_MMU=3Dn, yes?  Let's add the
> ifdefs to make it go away in that case.
>=20

Thanks, I missed that case. I will fix it.

>> +	struct mm_struct *mm =3D current->mm;
>> +	struct vm_area_struct *vma =3D NULL;
>> +	struct vm_area_struct *visited_vma =3D NULL;
>> +	unsigned long entropy[2];
>> +	unsigned long length, low_limit, high_limit, gap_start, gap_end;
>> +	unsigned long addr =3D 0;
>> +
>> +	/* get entropy with prng */
>> +	prandom_bytes(&entropy, sizeof(entropy));
>> +	/* small hack to prevent EPERM result */
>> +	info->low_limit =3D max(info->low_limit, mmap_min_addr);
>> +
>>=20
>> ...
>>=20
>> +found:
>> +	/* We found a suitable gap. Clip it with the original =
high_limit. */
>> +	if (gap_end > info->high_limit)
>> +		gap_end =3D info->high_limit;
>> +	gap_end -=3D info->length;
>> +	gap_end -=3D (gap_end - info->align_offset) & info->align_mask;
>> +	/* only one suitable page */
>> +	if (gap_end =3D=3D  gap_start)
>> +		return gap_start;
>> +	addr =3D entropy[1] % (min((gap_end - gap_start) >> PAGE_SHIFT,
>> +							 0x10000UL));
>=20
> What does the magic 10000 mean?  Isn't a comment needed explaining =
this?
>=20
>> +	addr =3D gap_end - (addr << PAGE_SHIFT);
>> +	addr +=3D (info->align_offset - addr) & info->align_mask;
>> +	return addr;
>> +}
>>=20
>> ...
>>=20
>=20

This one what I fix by next patch. I was trying to make patches separate =
to make
it easier to understand them. This constant came from last version =
discussion=20
and honestly doesn=E2=80=99t means much. I replaced it with Architecture =
depended limit
that as I plan would be CONFIG value as well.

This value means maximum number of pages we can move away from the next
vma. The less value means less security but less memory fragmentation. =
Any way
on 64bit systems memory fragmentation is not such a big problem.
