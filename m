Return-Path: <SRS0=ddTQ=GF=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AG47ELsH+oe1OkS7cM5t7NZW6gN0X2u6AE9ABpE3JUpYakeOvQ2kK04WXReF4pNuhiW3KHWVjLxY
ARC-Seal: i=1; a=rsa-sha256; t=1521131324; cv=none;
        d=google.com; s=arc-20160816;
        b=TkY3rrawdx5XXS+ZiCD39S8sgKYzXLAfDS02uQzKGJe0ikgkLppggS6MHI2J1mi7ss
         hMkVw0DbvvK+Lr65opg/yPo0+SPbLf4xedB2ntstc4kUmFWsQREHqznmgaWMa/4zdncE
         7uTrO2Ivw7ZBRTGro9Yx/ki9QiNMS4gzBcAx12rgP7QdzCCZLCBTWZa73qfTsxtt768t
         1yhBPYwZE/1ZuoWpnunVSB5lSzhHC8gz8b6JYL33Ddxxqx5V2iU9FvsyMSN5KXttRO0a
         wrdDkagUG7TbSuenEMDTUchDynlwhGJFzimepymPsn/V4IByLT94Ihl8vxKmaUBWRlr5
         xurw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=ftuiL4S2XjUXVWGZcH1n/0wW5Mi9HvP8Kh94EER3BzE=;
        b=RY+TAI2uDREEZhjxLBh/WMhq5ZF5kZ39rMCQkc0MnJLMetiE4e0phoXvEsKE0BLlzB
         8V0CMHgHAHYH6/jydZaxsbwg/XkLV5W0wqIvCHvccIrqRe8HR6627TC06W87HqU5w8kD
         RONr8cRp2BC1mL6WNAkg/h/bij48RAniP09Wm/JKbh6tEwxWiVx9mYn9/z7QT/gD/tlw
         rDxVbcorJe7LwK37SwD4rXluR70v1mTEX8IstVE7BQsqcsuX59kagMnUWJ179gJgInFF
         Zo+vFNPL0wpeiz36TBSrbebk5vbYNWniXSSUE9M9hsfaD46UkAEM1RwZID69GJnHtkh/
         2iWw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=ddtq=gf=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ddTQ=GF=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=ddtq=gf=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ddTQ=GF=goodmis.org=rostedt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA4C204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 15 Mar 2018 12:28:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
 srikar@linux.vnet.ibm.com, acme@kernel.org, ananth@linux.vnet.ibm.com,
 akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
 alexis.berlemont@gmail.com, corbet@lwn.net, dan.j.williams@intel.com,
 gregkh@linuxfoundation.org, huawei.libin@huawei.com, hughd@google.com,
 jack@suse.cz, jglisse@redhat.com, jolsa@redhat.com, kan.liang@intel.com,
 kirill.shutemov@linux.intel.com, kjlx@templeofstupid.com,
 kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
 naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, pombredanne@nexb.com,
 tglx@linutronix.de, tmricht@linux.vnet.ibm.com, willy@infradead.org,
 yao.jin@linux.intel.com, fengguang.wu@intel.com
Subject: Re: [PATCH 2/8] mm: Prefix vma_ to vaddr_to_offset() and
 offset_to_vaddr()
Message-ID: <20180315122840.02ac36ec@vmware.local.home>
In-Reply-To: <20180313125603.19819-3-ravi.bangoria@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
	<20180313125603.19819-3-ravi.bangoria@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827168615885864?=
X-GMAIL-MSGID: =?utf-8?q?1595021799628679453?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 13 Mar 2018 18:25:57 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> No functionality changes.

Again, please add an explanation to why this patch is done.

-- Steve

> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
