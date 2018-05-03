Return-Path: <luwei.kang@intel.com>
X-Google-Smtp-Source: AB8JxZrCb3zu0oF8+8bwlYwgkFQaQMHYC1swkoKn9XCfJKi2llkf5RlJh8QRYKbmTPS3aL/+EtM6
ARC-Seal: i=1; a=rsa-sha256; t=1525346351; cv=none;
        d=google.com; s=arc-20160816;
        b=ywF378Usr3PFGeJoLB9tmJWDEYNTJDgd9mH2FvZJmyPYpSuYhofqbxrC3TmEpfWcb9
         gIxjY8vUHdhMeE4XiH5dWtYrgpCDvzR152+VzP0b8ezaFGwh0EObVneoMQQ3UEfGUxeW
         81keElE5a7Q2NycrHo59fPY3Du/ncN5JWG8OXvEF5ZWWMJDVo7bEktCo9jM2JMTjtGVn
         b3u1/JpsMPCU37tMgNMPIsG45+9TGq6rRmeLaLN+YWce5dwoJS/x9mjG1iQQnBpCA5RD
         N0XbeW0cez5lp0uioj0EAVd6Qo+1gBdLB0BqdcnYf3Yg1CBiogoctElFMdqTge/bFuPQ
         KGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=Hs4hygdGd6huTyqpmOzzkgaJzFdeO01u4qQVZk7dGAU=;
        b=Wne2TVti2RCNEENPmaPf+GBTX3+EXWhVK4qpdjPB4b4ZSmLYtiULh6Bvb1FsjxKC5a
         bj7mnId9IDaZVQvUjTE+400WbBhgC8NPw6nzfuITo7gNtyTRoy1DqIohrkfcGbxqFJLM
         32KO8HR8/dTMflyz/nH+f4bNjB+PMPh0o5zMZduOfJPhj05bBcvX6HGTzy4QaWwEUjjB
         wzEP46qnSeiiNx0/PDqvDTPYBiqgpnreOT3QUbl2ynhUrBhPnU+X1yEO11JoIl/xXHlB
         FYv4m/sHwAXbILMtpruXBYu4gFpdCD/iR3IB6HBD/fNgfRN4Yel/iJaD15XXuzFgkVCN
         lyEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="37143424"
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "bp@suse.de" <bp@suse.de>, "brijesh.singh@amd.com"
	<brijesh.singh@amd.com>, "Liang, Kan" <kan.liang@intel.com>,
	"Janakarajan.Natarajan@amd.com" <Janakarajan.Natarajan@amd.com>,
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "mathieu.poirier@linaro.org"
	<mathieu.poirier@linaro.org>, "kstewart@linuxfoundation.org"
	<kstewart@linuxfoundation.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
Subject: RE: [PATCH v7 00/13] Intel Processor Trace virtualization enabling
Thread-Topic: [PATCH v7 00/13] Intel Processor Trace virtualization enabling
Thread-Index: AQHT4sgnBSK0KgL8jE+IQCs8ULXuEKQdy0Fg//9+owCAAIgX0A==
Date: Thu, 3 May 2018 11:19:08 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E167F6DE1A@SHSMSX101.ccr.corp.intel.com>
References: <1525349608-10352-1-git-send-email-luwei.kang@intel.com>
 <82D7661F83C1A047AF7DC287873BF1E167F6DD2C@SHSMSX101.ccr.corp.intel.com>
 <20180503103750.GY12217@hirez.programming.kicks-ass.net>
In-Reply-To: <20180503103750.GY12217@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGVlZTg5MjEtYTFjOS00NjhhLWI1NjQtOWNlZGU5NTZhYTlkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJQcUpyYnNrOUpONnpBSzQ0bjVrc2h2dXhCMjM5S3IrYklZQytDSFBvY3dEUmFrT3M2bHpBZnFhTVFDUTRJWjZyIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599441576370953108?=
X-GMAIL-MSGID: =?utf-8?q?1599441576370953108?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> On Thu, May 03, 2018 at 10:23:12AM +0000, Kang, Luwei wrote:
> > Send this patch set twice because path 2 send fail in the first time.
>=20
> Then just resend patch 2; also I have two copies of patch 2, so clearly i=
t _did_ send.

Cc all the maintainers and contributors.

Thanks,
Luwei Kang.
