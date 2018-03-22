Return-Path: <akpm@linux-foundation.org>
X-Google-Smtp-Source: AG47ELuC+ZR99tg43B3mhXLJaMP1Q3wzdmmBRMwALa2DNAaBCSLVtSasv0AkAP83CpNigBb5l1Lu
ARC-Seal: i=1; a=rsa-sha256; t=1521752091; cv=none;
        d=google.com; s=arc-20160816;
        b=0C2rUZz3uWt+mrResrbw7iUH8fpxkOEiFFLy0hE/sxlRai6Qa/QXEfgk/hYbjWxDJn
         /6dMLsFgZjoq3nlooz0iVHPRcXKkWo1UrY0HTWYSBkUhYXslPP+yzOXpJRIqT8csa3k/
         Yerv+Ua6WcKMQoTw5HXXdEoTOeGjxeH0M9T68oHiSmUfdwEWkbFZeuFPfoyzcChmZEd4
         2vVQMqzr/rAEqbjWUCNbEGBc9m+dV/ke13F/r0ljqXhrxammuguHdilYq/RKPDtIW2I+
         93FVcQ4tETm49Di6czR3CQnen7KI3XGDd+ruNP25bTwmCc3SpnARgUCEWl6eHzTZNloZ
         N5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=hh/KCqd0LCzFxXd8QQSwkWAKQMhgp2VK0c66eIw8uGY=;
        b=Al7Y4PXXPBGN6N/GVlMXYdSHrZ8L3gio+p959mL0BjF/FTSdogZacNzDus75vZG8+I
         C29z3ZOsXzk75bS73Fr5+oBWJwQVzJXLhWKTv2rBn08grynzoGJOPDb+fDd6qygDlY+4
         6eudpWB/kI0GJJz82aN15kcHnsgw9SJD2/mVOkOEXeoctatON9tJTTDlEdAsHT2LEGRt
         gUcPqY0NX18tkMVIzMiZErgswNhDq44q/h+BJy1o4ZtSKyI5/+CtPdGUSJecYYLk9m5g
         qUEkmY+Db06qNBhZdBPqLrKVdQ6dFjS3Tjaoy6k2LGF5K3dACgWkDX+Os40neAq3Wp6z
         WYoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Date: Thu, 22 Mar 2018 13:54:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ilya Smith <blackzert@gmail.com>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
 vgupta@synopsys.com, linux@armlinux.org.uk, tony.luck@intel.com,
 fenghua.yu@intel.com, jhogan@kernel.org, ralf@linux-mips.org,
 jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
 heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
 davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 x86@kernel.org, nyc@holomorphy.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
 gregkh@linuxfoundation.org, deepa.kernel@gmail.com, mhocko@suse.com,
 hughd@google.com, kstewart@linuxfoundation.org, pombredanne@nexb.com,
 steve.capper@arm.com, punit.agrawal@arm.com, paul.burton@mips.com,
 aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com, keescook@chromium.org,
 bhsharma@redhat.com, riel@redhat.com, nitin.m.gupta@oracle.com,
 kirill.shutemov@linux.intel.com, dan.j.williams@intel.com, jack@suse.cz,
 ross.zwisler@linux.intel.com, jglisse@redhat.com, willy@infradead.org,
 aarcange@redhat.com, oleg@redhat.com, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 2/2] Architecture defined limit on memory region
 random shift.
Message-Id: <20180322135448.046ada120ecd1ab3dd8f94aa@linux-foundation.org>
In-Reply-To: <1521736598-12812-3-git-send-email-blackzert@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
	<1521736598-12812-3-git-send-email-blackzert@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656493467338178?=
X-GMAIL-MSGID: =?utf-8?q?1595672721230452715?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Please add changelogs.  An explanation of what a "limit on memory
region random shift" is would be nice ;) Why does it exist, why are we
doing this, etc.  Surely there's something to be said - at present this
is just a lump of random code?
