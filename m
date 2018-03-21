Return-Path: <lsorense@csclub.uwaterloo.ca>
X-Google-Smtp-Source: AIpwx49eE2yJ3UB4FRVlGhAuL83E6dBndxpJD/12VuMMzvwqJfs0VVxXD0D9ssk7JMHzt2mIoZCu
ARC-Seal: i=1; a=rsa-sha256; t=1521650080; cv=none;
        d=google.com; s=arc-20160816;
        b=PCwb4E/E+9UQOYu3yQ5imDU/UA/JkI+j1Ll9UbBycEYLlSEiWZCXBan8JPTZEGYgKM
         h36ASXaQHCwqb+UN1ZJ2iDQkdChqufWGkRiJaF5DlghIkq4gptxB41f3G/BeU3Isv5t5
         jWfTYxflwzi+3hyZ8gDlRd0hpRax7mAbeSwVioDGLdlBjc5fUv/5RCka/qosI/0f31Gm
         nKaGtoYvKD7jxg/OvWUn/gUkx0RRz5Hv3zv3j0TNhn2pLNYswlt0TvFvQZEZ/jUibIOl
         BpVqpP5ynYq4k2MAhppvTZWtsW0Ld/aPt3X11Mov+jGvQ+ZE+34ugwwu7Kadg7Tzy2hV
         AA/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=from:user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:date:arc-authentication-results;
        bh=rWfWRKfMqq2ya0lyF2r3sO9syTxzaewUJRObHdpnIpY=;
        b=SqcvDVtqwS8EyG9hAyU63wJYCP301CR18K7k41xj2kW1no7cXdQoyml/BAFfp4UVjZ
         6DlpaoAq4j+QhjkgkdZKqPaPBQ5xnjW5H37PKc/55dV1DUSb73lbC8N/RpwdD8c6VD7Y
         GBZs02isDEtkly5IMZnAsCf0fRgPLuNipJCfLjb8E0wVlfXYXvcuH5fqeW0TmIKmNwW+
         A+ctQsg18c7uebKHFYJtbGh7oVVCrAn+/S4dKdo1i60vJn+h4DytRR7n+dOID9a2etXn
         pzkTkEvNYZMaaNuDqtU/m73lpeklc9C8WmPt/FdZHA+x6+S4v1yhmZldO34qJkpsb3VC
         wkUA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lsorense@csclub.uwaterloo.ca designates 129.97.134.17 as permitted sender) smtp.mailfrom=lsorense@csclub.uwaterloo.ca;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=csclub.uwaterloo.ca
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lsorense@csclub.uwaterloo.ca designates 129.97.134.17 as permitted sender) smtp.mailfrom=lsorense@csclub.uwaterloo.ca;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=csclub.uwaterloo.ca
Date: Wed, 21 Mar 2018 12:34:38 -0400
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: 4.9.80 compile failure with X86_VSYSCALL_EMULATION=n due to
 9a0be5af
Message-ID: <20180321163438.7q37vh7pncljib2a@csclub.uwaterloo.ca>
References: <20180212154325.ge4walt2m6u3ef7g@csclub.uwaterloo.ca>
 <20180321160424.GF18454@kroah.com>
 <1521649863.23626.130.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1521649863.23626.130.camel@codethink.co.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592210444043385757?=
X-GMAIL-MSGID: =?utf-8?q?1595565754263528723?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 04:31:03PM +0000, Ben Hutchings wrote:
> On Wed, 2018-03-21 at 17:04 +0100, Greg Kroah-Hartman wrote:
> > On Mon, Feb 12, 2018 at 10:43:25AM -0500, Lennart Sorensen wrote:
> > > Commit 9a0be5af added a reference to vsyscall_pgprot in
> > > arch/x86/mm/kaiser.c but that is undefined if X86_VSYSCALL_EMULATION=n
> > > which on an embedded system where you know how all your software is
> > > compiled is quite likely.
> > > 
> > > Of course the condition is always false with that config so the code
> > > will never be run, but the compiler is unhappy.
> > 
> > What is the compiler error?  I have not had any reports of this with all
> > of the varied builds that we currently run on the stable trees.
> 
> You already applied a fix for this ("kaiser: fix compile error without
> vsyscall").

Yeah the fix certainly works fine.  I was not the only one reporting it.

-- 
Len Sorensen
