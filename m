Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELtrOh9o3CbTesPmuptElWwce+1x7XtF+HaRGuT0t9P8WVBQrrnEPNrPxMxleUjNwvNj8qWz
ARC-Seal: i=1; a=rsa-sha256; t=1521140679; cv=none;
        d=google.com; s=arc-20160816;
        b=k/30o2oCufTT/M6NwoPV7iMJYsC1JZ78OlySUlkDKX3BVOxW4JXNu2YH7vRWjpm8SO
         6Bzez7vd8LG2JwyMO1KAWNcLbdWJMU9nI5daD3aGPSGZSNhR2Xd8nKHEPQaST8H6YEL4
         4zkA9SMDfTX6engg3U517Hi3XGGz7Zkxp4RhugmQB3/HnfA4aRa07TBoxtUPLqVIs1V3
         K3RenfAR758cj97eKZ02fovHOiJBeP98Q9N+lvWoB5y0imIHOzW1wWrdrefxbzZi8mKT
         aU+t380SFp5ko/AsjxOozVKD0kwkMtNcH1zp7G6MIviq5KYqM+jwSH606NnSIh10lxfY
         zZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Vems+Ih1SlkAxVbm0yhEdz5hGOowLNBFtQ0k5lQl+xA=;
        b=ueRJzUujoMrq76nXA+z0DyYaUaTKJIVNIpvHt61vyqjYsJYN5CLDdTWnzHp6kjMbmK
         u5DB1EhumIXJ4Hbsq6KdFymK31roOhEBMMmdCm7S/iQabaH+I4j4EIwZcnFa9x4QK5Pf
         mj0zKsjvz1CWq4J1AD3Ks71W70PH+RXQ4+nY/G0TWSnhWc5GXesLb84X4goORWzm+Iq4
         /Fp+v/HoMJHowni2rZJ6orm1He5s/GfSBtQ0l+3W+zI2W2u8zMZRwRh3K6AoIzuRkGXg
         xYr81xbJgitG4+NEWzDoDVQOFtA2xYueRSFMWOP9K7t3ErprwRhgYHdltjigVz6Z6INk
         zGJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=NUbppXls;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=NUbppXls;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Thu, 15 Mar 2018 15:04:30 -0400
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
Message-ID: <20180315190430.o3vs7uxlafzdwgzd@xakep.localdomain>
References: <20180131210300.22963-1-pasha.tatashin@oracle.com>
 <20180131210300.22963-2-pasha.tatashin@oracle.com>
 <20180313234333.j3i43yxeawx5d67x@sasha-lappy>
 <CAGM2reaPK=ZcLBOnmBiC2-u86DZC6ukOhL1xxZofB2OTW3ozoA@mail.gmail.com>
 <20180314005350.6xdda2uqzuy4n3o6@sasha-lappy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314005350.6xdda2uqzuy4n3o6@sasha-lappy>
User-Agent: NeoMutt/20180223
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803150169
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591143417186287050?=
X-GMAIL-MSGID: =?utf-8?q?1595031609050794641?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> 
> Attached the config. It just happens on boot.

Hi Sasha,

I have tried unsuccessfully to reproduce the bug in qemu with 20G RAM,
and 8 CPUs.

Patch "mm: uninitialized struct page poisoning sanity" should be improved
to make dump_page() to detect poisoned struct page, and simply print hex
in such case. I will send an updated patch later.

How do you run this on Microsoft hypervisor? Do I need Windows 10 for
that?

BTW, I am going to be on vacation for the next two week (going to Israel),
so I may not be able to response quickly.

Thank you,
Pasha
