Return-Path: <lsorense@csclub.uwaterloo.ca>
X-Google-Smtp-Source: AH8x227xvEMao0MnWg475z2leXcwwqhvcFHOd9F9Bzk/Wiv9W8S8pN6xR1xcazMhLrpIWhQFxGyF
ARC-Seal: i=1; a=rsa-sha256; t=1518450206; cv=none;
        d=google.com; s=arc-20160816;
        b=wSYYR6bAS8PbkSpcB/u6TvY6g/cYFmtlYZ+/+M6yFL7YoSxRcwXQObJhfCLr1KWT5r
         yUsG0rHzDeqgcpZolqNeljMP7VCJilQfHpEITNNEc7TH5Bsof+EfHpST7ZCOK6FBw+u/
         pey+pn2UYv8qBOTx4L5/VcBYqok6Hpd3KiRzZtri32DWqm3RMqaZPLYVLPLAupzNxnYG
         NODBXSJY4zfmx7yH8utqFDOVBeStDfgL4Iavejz9GcXw0xdPQl66y+Qly2AnI4uDhOJ5
         3NrZMCFy3HVrdd4t2ygBXhmoHI81ab/K1joGSQHWjBKrCSBlMqCh+zHIkGE7P5gXtSBe
         70ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=from:user-agent:content-disposition:mime-version:message-id:subject
         :cc:to:date:arc-authentication-results;
        bh=U7fHRSVPL9slsyOMjeIW1cPtW+r++fsNwbo/JyOKL9w=;
        b=g27w0MIXRzrfK/AhZmzgzg27Q0ipPpaG3VIsmCRlVBRFPn8TkqMPjS/KamZgjjnshJ
         DHyt+r25iTFGwDh9kkicNWTH/6ARS+SAHcKfIBuj0YIaKNXevX363hiXkJonEE54RYGo
         ZIp219Nj3S/eVbkak5bxGQ8kGgePBPf70Dav2vI6oUUfbgWKUSe17lG0Ua0gpdp63nGu
         gCP+BptXk9gAWf6R7PWFHKsCad9oy2c+Nv20qWcr6zTXM6oOd9Fl3H3r1Wxv5fBWESZ1
         vHXrQRG37iWZVtGBcge5WznrLuXvWyX4QYxo+ax5Hi44P2hafBMs609tMa2Sv6QbswvJ
         zSgw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lsorense@csclub.uwaterloo.ca designates 2620:101:f000:4901:c5c:0:caff:e12e as permitted sender) smtp.mailfrom=lsorense@csclub.uwaterloo.ca;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=csclub.uwaterloo.ca
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lsorense@csclub.uwaterloo.ca designates 2620:101:f000:4901:c5c:0:caff:e12e as permitted sender) smtp.mailfrom=lsorense@csclub.uwaterloo.ca;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=csclub.uwaterloo.ca
Date: Mon, 12 Feb 2018 10:43:25 -0500
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>,
	Len Sorensen <lsorense@csclub.uwaterloo.ca>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: 4.9.80 compile failure with X86_VSYSCALL_EMULATION=n due to 9a0be5af
Message-ID: <20180212154325.ge4walt2m6u3ef7g@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592210444043385757?=
X-GMAIL-MSGID: =?utf-8?q?1592210444043385757?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit 9a0be5af added a reference to vsyscall_pgprot in
arch/x86/mm/kaiser.c but that is undefined if X86_VSYSCALL_EMULATION=n
which on an embedded system where you know how all your software is
compiled is quite likely.

Of course the condition is always false with that config so the code
will never be run, but the compiler is unhappy.

-- 
Len Sorensen
