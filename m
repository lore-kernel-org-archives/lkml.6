Return-Path: <SRS0=ddTQ=GF=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AG47ELvIXSDa0WRjIvAozzlMwyPP/tc4VpZimzyOwfFsj1iTNN+bU6uL0bmgcllEsLXEPJcz8b+h
ARC-Seal: i=1; a=rsa-sha256; t=1521131277; cv=none;
        d=google.com; s=arc-20160816;
        b=l34UhIe78qFunglWLD69esIOgPtIaFGJ3Lmn3RTTu012LAX0hoLpO19eAS/NYLVIMp
         zEMY0MgiUvVxz3IlX1hlPrqCl4LPw0vUt3Vdo0TJ4Jkd5pLX6of0eJM/+xYaoZ5z1zJI
         NI+XRX/+hbK89FONRHUE0TzOWl/pEYn/udIAO2avkPPetLQpi9KTLdpQEtAr0PUityqZ
         88H6SWb6mS2US/6PpRP9SHfJAFIetnlsRlFL+KjgD2cYjVtmn3DLDxvqojbARIWlmQ5F
         owPAX1glSJiIXIBBUK+TNfCyZgepxL8qbqIhvfPxNF7mIBn47v1CNRjx9hBRbLNoBhbY
         UZ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=3H2zz3j4AjIHobi7ThcaUjZinjmmK1EZ9mzAFJfVqsE=;
        b=XSYAv4nxE0GQDCbaGO+Dur88/cIsG2Co4KVpWLvFjQ9F0Ln9rNXGRA/HeAj/DuxegT
         K1IYZpcxmNmbuYmbNO1GYAivDcaB+MPIf8ZsjtYw9kXWA6wFvrf4Zh/40fq6kMneI7Ls
         1xvSAaNiYn9ng2WWhq02vBjrE2HZETnp4dAgwv/V5qU3wF+y8xExS2RN8UaOIFulCXzU
         v6b4xTkL4u0V/2c3soypnuVro4IVV3FBkvqTeeddaLIDi06tApq9zQaXtJAp2UUKNr/M
         GYTm3g2fHopq7vO1sPz1QsNrda3cX26HxjoOnvn5Qe6iVyRCETarJc9Wnu5x7sGsOqZ1
         pFGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=ddtq=gf=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ddTQ=GF=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=ddtq=gf=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ddTQ=GF=goodmis.org=rostedt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1A820779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 15 Mar 2018 12:27:53 -0400
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
Subject: Re: [PATCH 1/8] Uprobe: Export vaddr <-> offset conversion
 functions
Message-ID: <20180315122753.258c38df@vmware.local.home>
In-Reply-To: <20180313125603.19819-2-ravi.bangoria@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
	<20180313125603.19819-2-ravi.bangoria@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827116225046806?=
X-GMAIL-MSGID: =?utf-8?q?1595021750853975566?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 13 Mar 2018 18:25:56 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> No functionality changes.

Please add a detailed explanation why this patch is needed. All commits
should be self sufficient and stand on their own. If I were to come up
to this patch via a git blame, I would be clueless to why it was done.

-- Steve


> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
>
