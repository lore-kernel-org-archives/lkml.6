Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AIpwx4/k256cnfhpRDAGXTbzENBrb6DgSr12KpISwEhrcy0SiSgdOq0ZzN0gQZox1ZE+gygHChEb
ARC-Seal: i=1; a=rsa-sha256; t=1522808278; cv=none;
        d=google.com; s=arc-20160816;
        b=bzhhL1dYtI1latEL1tblG83s87zQH26NDYvE5TxmH4r9UYOdthh3BCuVlbu3ug3pzr
         nbTMCnZqaSKdLAwZAlY0oPxyfKisp37utmFr+aTwaYx3q++kRWUM1CsgjkY1tA7k0lG3
         FQ/Rvw8jKtRnZ4hkyjLLhrlgQSjP/Kq4w0eRScqhn3dT+uFgxFlIePDkkdEej+f1Na7H
         X4n7qjDvHB8o1fLiBIaa4nD2GyuBhM29kb7ZovNwR33+TdJIzldMXQsyP159i6OZFU7j
         SiyIbD6Gal05WHz3IW1GGm0hZ6SsSNBtCdiiv8IJnxLW3oAuOhx/HL6PlUCn2XZsZP2K
         IL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=DJH9KQ1N+QUPysEiNwEyftGI1jYYk7862zjxIICd+pc=;
        b=rzb9zPYtggu04tYV7Ke6Av+5YyyFG9nW4V94rdhMlr0ldfsplsVDl+pqh+9+KWOymF
         CUrDbkovBoMgRZZoFs8h5s2K9MfhVFWuZJw4WJ8qZ+UFOWGMiGN96nwW6Q9O9PtFY+/Z
         8+clBYgtP88v6YEnUGzcrZ6BSdyyAkid52JLOOC6b/X+3tewL0MqCgjeojDiHkF+poBI
         DRKBMwP5Xs02j9HqMTYqSyvxLBpyQXkmcFOJfnvYnBnMSUekIvu36EsGmgwbQ0649okF
         /tKotU3242GEOrJMsRWJoZL4V/cHJjrdx2KUr8o3IKFfX4ljO/JC3u/DpAIwRiWLlJMh
         h1Qg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=WFLlWXqP;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=WFLlWXqP;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Tue, 3 Apr 2018 22:17:46 -0400
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
        "daniel.m.jordan@oracle.com" <daniel.m.jordan@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] mm: uninitialized struct page poisoning sanity
 checking
Message-ID: <20180404021746.m77czxidkaumkses@xakep.localdomain>
References: <20180131210300.22963-1-pasha.tatashin@oracle.com>
 <20180131210300.22963-2-pasha.tatashin@oracle.com>
 <20180313234333.j3i43yxeawx5d67x@sasha-lappy>
 <CAGM2reaPK=ZcLBOnmBiC2-u86DZC6ukOhL1xxZofB2OTW3ozoA@mail.gmail.com>
 <20180314005350.6xdda2uqzuy4n3o6@sasha-lappy>
 <20180315190430.o3vs7uxlafzdwgzd@xakep.localdomain>
 <20180315204312.n7p4zzrftgg6m7zw@sasha-lappy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315204312.n7p4zzrftgg6m7zw@sasha-lappy>
User-Agent: NeoMutt/20180323
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8852 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804040020
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591143417186287050?=
X-GMAIL-MSGID: =?utf-8?q?1596780213750089873?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18-03-15 20:43:14, Sasha Levin wrote:
> On Thu, Mar 15, 2018 at 03:04:30PM -0400, Pavel Tatashin wrote:
> >>
> >> Attached the config. It just happens on boot.
> >
> >Hi Sasha,
> >
> >I have tried unsuccessfully to reproduce the bug in qemu with 20G RAM,
> >and 8 CPUs.
> >
> >Patch "mm: uninitialized struct page poisoning sanity" should be improved
> >to make dump_page() to detect poisoned struct page, and simply print hex
> >in such case. I will send an updated patch later.
> >
> >How do you run this on Microsoft hypervisor? Do I need Windows 10 for
> >that?
> 
> Booting a Linux VM on Azure would be the easiest, and free too :)

Hi Sasha,

I have registered on Azure's portal, and created a VM with 4 CPUs and 16G
of RAM. However, I still was not able to reproduce the boot bug you found.

Could you please try an updated patch that I sent out today, the panic
message should improve:

https://lkml.org/lkml/2018/4/3/583

Thank you,
Pasha
