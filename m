Return-Path: <DavidWang@zhaoxin.com>
X-Google-Smtp-Source: AB8JxZqYcCs8Kg6QhgWyabDzIhb8TRZhAL3aiGc/rmcWuLFOpc2AI8S/YkXfls6kYkdFb4Y493DJ
ARC-Seal: i=1; a=rsa-sha256; t=1525245293; cv=none;
        d=google.com; s=arc-20160816;
        b=YpdFp67mtY4WNpHnXTA8KlDBKNCWKr0WamyN1UoF2Ik+M0caT/8k+vEuU8WIU5aeCP
         RtfBLqyR0w3HIxOcoT6qWASlpVwVBcatKEcb6sENKMQQR1e7jxrz07s/3SlhazJSLH0O
         n7wzjbKadCGBkXfCNMqlv01g3umyYvdHbuftDW38AE5nhvxDFV5i5FjLsqwmwjkpipRD
         CALPsHaIyhVMS33ifY9tmmDn1L046Nkx2VZkUyhT6X1dAuvRO+f2W5QvorYsoqjmcIy8
         GBOhESWYQEPi7BaA3qEgw2b7GkfgVATKCm1CJrtqvAGsL/37KK6DTFnhZ/hKkuue/+7n
         Y76g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=dyASemNqHyWpnN13MHqA8Do8XTE0mICQe/Hee8bRYj0=;
        b=XvkdGhPJlwrZtkmUdOQyxLa99YRi4mJihVcmdOmcJlF1zLwnX84NREziwk4UBZiZUP
         NhTi8zyFp9D4/TAyOm9IKJCwXyIYaFXm0ZMT3Q7g9Bad5yPCuJwYvRXTScaVQuxHaRLq
         O1Psv0BkQtQogqhSy4acGJwTCpco6/HNYB1mnRYrn6OhM9f/IdgAsP/omI3XCvEt1QEn
         61e2m7Bv6qXKjLkQD3bUqh8/zIcmtmxu9JNY+V1L1/+imGDwLN30jeL+qbYT2NV/VpoU
         HlyMnx63oxLwDNBQ3go7LPtN3LzSyonKwWDN3j5D3C61o5D8g+oyFbbtcmdMdgubhcOE
         k55g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 203.148.12.81 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 203.148.12.81 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
From: David Wang <davidwang@zhaoxin.com>
To: 'Thomas Gleixner' <tglx@linutronix.de>
CC: <mingo@redhat.com>, <hpa@zytor.com>, <gregkh@linuxfoundation.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
	<qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>, <lukelin@viacpu.com>,
	<timguo@zhaoxin.com>
Subject: Re: [PATCH v3] report correct CPU/cache topology
Date: Wed, 2 May 2018 15:14:35 +0800
Message-ID: <000001d3e1e5$39b15640$ad1402c0$@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdPh5OZG/ZPAdTjOTuCfG5Pk1Np1sQ==
Content-Language: zh-cn
X-Originating-IP: [10.29.8.18]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598805408410089263?=
X-GMAIL-MSGID: =?utf-8?q?1599335607908800243?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Mail-----
> Sender: Thomas Gleixner [mailto:tglx@linutronix.de]
> Time: 2018=C4=EA4=D4=C226=C8=D5 19:56
> Receiver: David Wang <davidwang@zhaoxin.com>
> CC: mingo@redhat.com; hpa@zytor.com; gregkh@linuxfoundation.org;
> x86@kernel.org; linux-kernel@vger.kernel.org; brucechang@via-
> alliance.com; cooperyan@zhaoxin.com; qiyuanwang@zhaoxin.com;
> benjaminpan@viatech.com; lukelin@viacpu.com; timguo@zhaoxin.com
> Subject: Re: [PATCH v3] report correct CPU/cache topology
>=20
>=20
>=20
> On Thu, 26 Apr 2018, David Wang wrote:
>=20
> > Centaur CPUs enumerate the cache topology in the same way as Intel
> > CPUs, but the function is unused so far.
> > The Centaur init code also misses to initialize x86_info::max_cores,
> > so the CPU topology can't be described correctly.
> >
> > Initialize x86_info::max_cores and invoke init_intel_cachinfo() to
> > make CPU and cache topology information avaliable and correct
>=20
> Now that looks pretty good.
>=20
> > Signed-off-by: David Wang <davidwang@zhaoxin.com>
> >
> > Changes from v2 to v3:
> > *1 define new detect_num_cpu_cores() in common.c to replace the
> > original intel_num_cpu_cores;
> > *2 move cpu_detect_cache_sizes inside init_intel_cacheinfo.
>=20
> But I asked for that being a separate patch with a separate changelog. =
And
> the intel_cache_info() change wants to be in a separate patch as well.
Then
> the third patch is the one which makes use of these changes for =
centaur.
>=20
> Please read review comments carefully and rather ask when you have
> doubts about the meaning.
>=20
> Thanks,
>=20
> 	tglx
>=20
	Sorry!=20
	I will split the changes to three separate patches.
	Thank you.
---
David
