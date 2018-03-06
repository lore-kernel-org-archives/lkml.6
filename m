Return-Path: <akpm@linux-foundation.org>
X-Google-Smtp-Source: AG47ELtAJcNtBomfOeVCHz7Cb3eXpMGDBXWQzvuag1ht3lpzhnffX5koa4BEispTCuHubreS5lf9
ARC-Seal: i=1; a=rsa-sha256; t=1520376523; cv=none;
        d=google.com; s=arc-20160816;
        b=oYjbLacFflPpNAxXdEG6hJpAgTfoAkCx1jbC8CEooPi8RuuZ9PoDGhEy3V1hpSfiVG
         O22DfFeqvWyo8y19wywOAD6XMJTTUWld0OJuZ1YXfpReqJWdIzxfBni6hAAN1VFmNWmR
         1BqbEi2eVlEGoE0xU7FlVqsc1dPwNHKO+RTymh3MKsFUkT7KTJGx8UFcWggb73/CMJkW
         pqnDuGe10UCiOwthRYc5Jd9QlxJRHv3812yjxxbVwDlsyb1iffVMAHkhMr7eNea0JiGg
         Qw1j/7MkJPKDJ6t1JxVImW67JwzBFMQzniDeEdxuBLG3aFtkhuFacTbujKjb+ecForT2
         G2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Yvste6i3GR9/5p9d07wnFoQlWNOO1pt5djFDHNgm6s8=;
        b=XW2GI6wwaE+dez44z8nayrH2pKqPC+84IXeRLMtuYk4Etvn2eyPMG4FPBF9sHYkugR
         i+L1MgkFfasUGJzu9toFrdgZqJ+l/Y/H+bTWD91Zyk0cS2yIROeYjMRH2a+37tXiDBbp
         7s7HcpWgM+YyQq34mlaVc+0oK+wUil/XZ7Xx2e4irfJqx4BQC28glhD783P+wUAM0+Lv
         Ql25ECQB8NmqohfI1wFvYInIBiixfqlSXJ0iX5nXbLs18wQkxS1DzXuEWvq8lXZymik7
         Didsrz53EVvvjAMI49Ns8UkM4iLTrce8/pvwBVlSYKZvLk8KSoQQRxW/y+H1O6BMCO4M
         sQYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Date: Tue, 6 Mar 2018 14:48:07 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 davem@davemloft.net, dave.hansen@linux.intel.com, bsingharora@gmail.com,
 nborisov@suse.com, aarcange@redhat.com, anthony.yznaga@oracle.com,
 mgorman@suse.de, linuxram@us.ibm.com, kirill.shutemov@linux.intel.com,
 dan.j.williams@intel.com, jack@suse.cz, ross.zwisler@linux.intel.com,
 gregkh@linuxfoundation.org, tglx@linutronix.de, mhocko@suse.com,
 n-horiguchi@ah.jp.nec.com, jglisse@redhat.com, henry.willard@oracle.com,
 aneesh.kumar@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, sparclinux@vger.kernel.org, Khalid Aziz
 <khalid@gonehiking.org>
Subject: Re: [PATCH v12 07/11] mm: Add address parameter to
 arch_validate_prot()
Message-Id: <20180306144807.30915bcffe6e640c3ad6279c@linux-foundation.org>
In-Reply-To: <349751cbd54fda6f4a223f941aa71bbfe7be77ce.1519227112.git.khalid.aziz@oracle.com>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
	<349751cbd54fda6f4a223f941aa71bbfe7be77ce.1519227112.git.khalid.aziz@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031745545119756?=
X-GMAIL-MSGID: =?utf-8?q?1594230333453251501?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 21 Feb 2018 10:15:49 -0700 Khalid Aziz <khalid.aziz@oracle.com> wrote:

> A protection flag may not be valid across entire address space and
> hence arch_validate_prot() might need the address a protection bit is
> being set on to ensure it is a valid protection flag. For example, sparc
> processors support memory corruption detection (as part of ADI feature)
> flag on memory addresses mapped on to physical RAM but not on PFN mapped
> pages or addresses mapped on to devices. This patch adds address to the
> parameters being passed to arch_validate_prot() so protection bits can
> be validated in the relevant context.
> 
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> Cc: Khalid Aziz <khalid@gonehiking.org>
> Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>

Acked-by: Andrew Morton <akpm@linux-foundation.org>
