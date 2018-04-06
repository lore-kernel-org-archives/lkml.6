Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AIpwx4+PogoTSlX9LTtdeA/5zrEf9OHMPD/GaSeFAM25woQ9DPvdz8yEEDRfyvjhT/krL/5Vk+hh
ARC-Seal: i=1; a=rsa-sha256; t=1523018744; cv=none;
        d=google.com; s=arc-20160816;
        b=0UA8Z8mTwcJcqd3CxEs9EZ/iePKPhYPpo77Gowo2I9vx/10Sg8LqOrxteJ8OolFpVw
         lvxTbZVJ1aK2t4yjen2/11GiiIj62totr5+GtPt3NCJajzHEZKSWa/tCzwhfOA8Xxku8
         FuMGfIUcSh0s4Mks8T7aWTPsx/KfAvdZYdoUkG2JFHPtbQEpwFixrB5s0YS6aT9dGyc6
         3OKwoSpPzLXAbx8HUcvVHyzKIxAQJ+phdIu+gA/ZTSogmyVDaik+x8PtRji/jIYDZP14
         2egfZPj2GRrFtr/29CfhXi/R8UhauWX/OJc3d694Lvqf7syiwEODSPR7WiVtdc8aRjIw
         g5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=vpI2KPvL7MAIWeOKOkR3LauPO515V2XhumcKsnrEACg=;
        b=UdduMlDO7VqKoOusJvOCwVt+iVhYDJfvkoP5w6Nf/PDx3YVfP3FL8H8JTNvNAPEFpe
         5zcboVbNr1xFHTIPQGo4Jdz1G0OHnL52zCdH7nGLnDkqPRydRalBBkHLvFwb4d/Hmp0h
         Hwu/+HpDXKfshrVVo8pSpePvYxd+mlAEGyy7XcukSUHkaJa14AFL+Ead3Zwfkr8wh/Ck
         YDIqdR+w6/apEeoOdCKbhcxWjfvzZDTwUk6/kRF6gCRbkYEEJHISAVNb1mTel/NPQ1+P
         Nln+8GM6ujDu5b9HKWjtn7uV2eWVyx6J1+kZhpXBNW0tKIq1iJh33/dZR++bLp53eFdP
         O88w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=t5t6oCHc;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=t5t6oCHc;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Fri, 6 Apr 2018 08:45:35 -0400
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
Message-ID: <20180406124535.k3qyxjfrlo55d5if@xakep.localdomain>
References: <20180131210300.22963-1-pasha.tatashin@oracle.com>
 <20180131210300.22963-2-pasha.tatashin@oracle.com>
 <20180313234333.j3i43yxeawx5d67x@sasha-lappy>
 <CAGM2reaPK=ZcLBOnmBiC2-u86DZC6ukOhL1xxZofB2OTW3ozoA@mail.gmail.com>
 <20180314005350.6xdda2uqzuy4n3o6@sasha-lappy>
 <20180315190430.o3vs7uxlafzdwgzd@xakep.localdomain>
 <20180315204312.n7p4zzrftgg6m7zw@sasha-lappy>
 <20180404021746.m77czxidkaumkses@xakep.localdomain>
 <20180405134940.2yzx4p7hjed7lfdk@xakep.localdomain>
 <20180405192256.GQ7561@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405192256.GQ7561@sasha-vm>
User-Agent: NeoMutt/20180323
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8854 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804060127
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591143417186287050?=
X-GMAIL-MSGID: =?utf-8?q?1597000903772458023?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18-04-05 19:22:58, Sasha Levin wrote:
> On Thu, Apr 05, 2018 at 09:49:40AM -0400, Pavel Tatashin wrote:
> >> Hi Sasha,
> >>
> >> I have registered on Azure's portal, and created a VM with 4 CPUs and 16G
> >> of RAM. However, I still was not able to reproduce the boot bug you found.
> >
> >I have also tried to reproduce this issue on Windows 10 + Hyper-V, still
> >unsuccessful.
> 
> I'm not sure why you can't reproduce it. I built a 4.16 kernel + your 6
> patches on top, and booting on a D64s_v3 instance gives me this:

Hi Sasha,

Thank you for running it again, the new trace is cleaner, as we do not get
nested panics within dump_page.

Perhaps a NUMA is required to reproduce this issue. I have tried,
unsuccessfully, on D4S_V3. This is the largest VM allowed with free trial,
as 4 CPU is the limit. D64S_V3 is with 64 CPUs and over $2K a month! :)

Let me study your trace, perhaps I will able to figure out the issue
without reproducing it.

Thank you,
Pasha
