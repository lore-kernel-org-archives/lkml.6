Return-Path: <DavidWang@zhaoxin.com>
X-Google-Smtp-Source: AB8JxZop9s+PgDHDL0MH3QzGOEVzn9zMSRxxr7OQnMI0WV8uUZg5qS9xe6MEonUatzsBjYAI96KB
ARC-Seal: i=1; a=rsa-sha256; t=1525255349; cv=none;
        d=google.com; s=arc-20160816;
        b=T4d4/fFcraypVQgTOZkXLMmkaSouHxXkTRC9hLK4G60MWAX5GI2sQjayaPBM6+0f4a
         1/KZGiX6Ze4lg7fBTRlbAVL1QhPRO1g0VqE7ISwYrvzhTob3OQptQhmaDB5px90hVe8V
         gRgFKa7xinl2csDSlWDCx4v3lv4FwO532A8ru1zLOC38/6ooAYdN5iug27hjN/TfXasp
         m62anUbqDhRgzsaf8i4oCG33JhARJCPmk3H3GxcKuH9jZJelrrsVE6+jPiXfp2lIoo8K
         InI1PQ3MXYe4fU5R9cLuVl+wsq/DhjEDmCJUVM3lWsq3ikeOmtroq9ksGFZAFOkBVHRn
         Yb/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ivP3J+RJA9QqjOy252UUe0jjX71KtO1jRGgruYysnwI=;
        b=pCphoQZoVbg2KPj++GkybYHXlHIECJRpYCoUgzDNJG6yUjg7zcCkbs/NPgcsmp3rGQ
         RHBZU1mxfICZTIyLCSVVkJj1snpeqPXX5q6zM/H2q5mZYZZPhSYI1v34lH1+yzWwkZRo
         lvOqwh0TPS65AWmjFEqbWrITrux6eivIvkINYCdO+iGEn1AlacIvb7+agy+MeUW+VkOb
         3cG4O2rFm0vI5DhtOhM9VBSJIrhNfqmtepH6CudEE/sn8GoW/bCD2Lw4SBYAsSdjeLuj
         qDN14jjlxVnn9cA4Jyu8kc4qHi09xIjngj2KLd1v5hVNfE1KHRfe/JJ0MNv/wKh2qnKG
         UMeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 203.148.12.81 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 203.148.12.81 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
From: David Wang <davidwang@zhaoxin.com>
To: 'Borislav Petkov' <bp@alien8.de>
CC: <tony.luck@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
	<qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>, <lukelin@viacpu.com>,
	<timguo@zhaoxin.com>
Subject: Re: [PATCH v3 2/2] x86/mce: add CMCI support for Centaur CPUs
Date: Wed, 2 May 2018 18:02:12 +0800
Message-ID: <000001d3e1fc$a3fd21c0$ebf76540$@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdPh/HTT7L1z+0x3QWSEHUB3WrRpXA==
Content-Language: zh-cn
X-Originating-IP: [10.29.8.18]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598713954946471832?=
X-GMAIL-MSGID: =?utf-8?q?1599346152630859776?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Mail-----
> Sender: Borislav Petkov [mailto:bp@alien8.de]
> Time: 2018=E5=B9=B44=E6=9C=8830=E6=97=A5 17:48
> Receiver: David Wang <davidwang@zhaoxin.com>
> CC: tony.luck@intel.com; tglx@linutronix.de; mingo@redhat.com;
> hpa@zytor.com; gregkh@linuxfoundation.org; x86@kernel.org; linux-
> kernel@vger.kernel.org; linux-edac@vger.kernel.org; brucechang@via-
> alliance.com; cooperyan@zhaoxin.com; qiyuanwang@zhaoxin.com;
> benjaminpan@viatech.com; lukelin@viacpu.com; timguo@zhaoxin.com
> Subject: Re: [PATCH v3 2/2] x86/mce: add CMCI support for Centaur CPUs
>=20
> On Wed, Apr 25, 2018 at 06:33:40PM +0800, David Wang wrote:
> > Newer Centaur support CMCI mechnism, which is compatible with INTEL
> CMCI.
> >
> > Signed-off-by: David Wang <davidwang@zhaoxin.com>
> > ---
> >  arch/x86/kernel/cpu/mcheck/mce.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/x86/kernel/cpu/mcheck/mce.c
> > b/arch/x86/kernel/cpu/mcheck/mce.c
> > index 38ccab8..f9a7295 100644
> > --- a/arch/x86/kernel/cpu/mcheck/mce.c
> > +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> > @@ -1757,6 +1757,8 @@ static void __mcheck_cpu_init_vendor(struct
> cpuinfo_x86 *c)
> >  		}
> >  	case X86_VENDOR_CENTAUR:
> >  		mce_centaur_feature_init(c);
> > +		mce_intel_feature_init(c);
> > +		mce_adjust_timer =3D cmci_intel_adjust_timer;
>=20
> This won't work in configs with CONFIG_X86_MCE_INTEL disabled.
>=20
> You need to define CONFIG_X86_MCE_CENTAUR or so which depends on
> CONFIG_CPU_SUP_CENTAUR and CONFIG_X86_MCE_INTEL and which then
> makes sure the intel CMCI et al stuff is enabled.
>=20
> --
> Regards/Gruss,
>     Boris.
>=20
> Good mailing practices for 400: avoid top-posting and trim the reply.

	OK. I got it.
	I will send another patch.
	Thank you.

---
David
