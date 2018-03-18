Return-Path: <davem@davemloft.net>
X-Google-Smtp-Source: AG47ELuphib3AKqFsX8nJePb2GjWNQffQSPfwBjSNJXX6gtdk2X13zgh+cJFrQCNINPNYzJEMou9
ARC-Seal: i=1; a=rsa-sha256; t=1521385744; cv=none;
        d=google.com; s=arc-20160816;
        b=RFDKRZnD0STFGvWhZODH28NMygG7j6DLwPyXmw/LOcvamP67Lmn8boFN87oA67sdfO
         i4q9558cgOPR9+vvAWWCNB3XkrdCtTR8JZDmodznVlIN0Gi6hHYbgk97G5TR7tJX97mD
         g+Z5j7fnqFbfJU62MF/Vj39PuEf/tTzWTqvQOw+Be1OKLCIIUr+Fn0Co5OPdzCbIoKrc
         d3rVlhjDJVRw+DsEwGuyS4uMGPr+Lh2bTvLFJtJvs/FXi4Y+WpWcEBWZ/h5DjvhDtpx3
         xsqmh/rhe0myT4BvaC5O3WYteLJW5abVfbpAaEiAo6NSjCw5eZqDSC3/30luyf/h4HLF
         CoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:arc-authentication-results;
        bh=KUEAcmBjkoB+lWhBQjgEfZ3z7G9BlYtawVoWvxXzN5I=;
        b=g2mIL9vKMteAFAsNVdZTbwuV2XbTQ9mrZj0a6FtxcOxNQjbLlFqecrrPvlU4nxtHkF
         J4mN3oTNmUwLyWbGMizacPdiWgtVAT30oopTaBli6Yyk/AgaubMD8BeS0qdcVnN1QsoI
         tU5EDwDjRW/3gA3kgWJURM2b0fIRfoDhRL+kCSjsOYHO7PLp35P1g/jo1xGFaKc/9wJ3
         Vtj3+Cin1CJgTH53Xf2MQJKlX5nu+Pr9qZpKJz2NY9z1ytF5zgHyvtqUICVIuuTstgpq
         0VKjQ35WqtTU5EYh9r3jjLKRnOYk/TrB4i2E/ZTUKfUHb1jcaDhj9LrR8XDNiqVICCRx
         wX/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Date: Sun, 18 Mar 2018 11:08:57 -0400 (EDT)
Message-Id: <20180318.110857.1660518649370410007.davem@davemloft.net>
To: khalid.aziz@oracle.com
Cc: dave.hansen@linux.intel.com, aarcange@redhat.com,
 akpm@linux-foundation.org, allen.pais@oracle.com,
 aneesh.kumar@linux.vnet.ibm.com, anthony.yznaga@oracle.com, arnd@arndb.de,
 benh@kernel.crashing.org, bob.picco@oracle.com, bsingharora@gmail.com,
 corbet@lwn.net, dan.j.williams@intel.com, dave.jiang@intel.com,
 david.j.aldridge@oracle.com, dwindsor@gmail.com, ebiederm@xmission.com,
 elena.reshetova@intel.com, gregkh@linuxfoundation.org, hannes@cmpxchg.org,
 henry.willard@oracle.com, hpa@zytor.com, hughd@google.com,
 imbrenda@linux.vnet.ibm.com, jack@suse.cz, jag.raman@oracle.com,
 jane.chu@oracle.com, jglisse@redhat.com, jroedel@suse.de,
 khalid@gonehiking.org, khandual@linux.vnet.ibm.com,
 kirill.shutemov@linux.intel.com, kstewart@linuxfoundation.org,
 ktkhai@virtuozzo.com, liam.merwick@oracle.com, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linuxram@us.ibm.com,
 linux@roeck-us.net, me@tobin.cc, mgorman@suse.de,
 mgorman@techsingularity.net, mhocko@suse.com, mike.kravetz@oracle.com,
 minchan@kernel.org, mingo@kernel.org
Subject: Re: [PATCH v12 00/11] Application Data Integrity feature
 introduced by SPARC M7
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1519227112.git.khalid.aziz@oracle.com>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031775429403993?=
X-GMAIL-MSGID: =?utf-8?q?1595288578781657698?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 21 Feb 2018 10:15:42 -0700

> V12 changes:
> This series is same as v10 and v11 and was simply rebased on 4.16-rc2
> kernel and patch 11 was added to update signal delivery code to use the
> new helper functions added by Eric Biederman. Can mm maintainers please
> review patches 2, 7, 8 and 9 which are arch independent, and
> include/linux/mm.h and mm/ksm.c changes in patch 10 and ack these if
> everything looks good? 

Khalid I've applied this series to sparc-next, thank you!

But one thing has to be fixed up.

In uapi/asm/auxvec.h you conditionalize the ADI aux vectors on
CONFIG_SPARC64.

That's not correct, you should never control user facing definitions
based upon kernel configuration.

Also, both 32-bit and 64-bit applications running on ADI capable
machines want to compile against and use this informaiton.

So please remove these CPP checks.
