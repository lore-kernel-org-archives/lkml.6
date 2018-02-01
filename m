Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x225GEt6FqYQse/rb3qT2te890qZKqrakpsuoD+4ajVPuKGb18Xv/vA5r+x3lOT8/KwNFcr3s
ARC-Seal: i=1; a=rsa-sha256; t=1517496543; cv=none;
        d=google.com; s=arc-20160816;
        b=frFo+kfgCXz4e2QBLbwIQ0WOfM5ey6SlXu57IY1LXgYVC+T/e9+aXGbEtbvkKt60PT
         aBpFOu+GGw4I/8y7kG9FsLBUM6BJRwIrHhp6hJGRx+iXtJTyPa4Y/a1fe1+StozX9qbm
         K6yVcOEK3J9YeM05DpVxNjYIgW+eE994vf4WDtfxk6MUN/jcZqEZ6W+MmZFWcPLvoPVD
         9Px6GaRpkEsko9lFgvXFvMYes5rki+OyOaowRkMdJfm+ZkoPQC8mpAGizzGekqC1+csQ
         ipRMwyhP8Wz5yKk69yTfIdkIttg9PtQ6iBbpssau1Bzd5j9kYRvrbxwqCM06ufFd+RI9
         iwWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:cc:to:from:date:user-agent:message-id:dkim-signature
         :arc-authentication-results;
        bh=DvQDi6wSDPv1nZw1jALRDEgKd02rA1HD5SmnvalZChA=;
        b=c5KnWm7E913JJMZ66NlnOpAW5Pgq8MH0NMAPz0yxqO9cz9oeGtdEAjHNXlsJ+LxfzJ
         4fG7370R6T6f8dRXOWr5RmcI3+embOHtq3OYfWB0vNWeUymReXviEdhjlNFGzAvCDL71
         1eYAeHNT92SBYcpmfJQFt6epIAz5qkTPiIh+dwMK3VhsvwGpXlpjKnoUNkvdypiN290O
         8Y6FFLxAVKjcCvTM2/lqDggbpFTjYWfnQGqtsuVFQQOGtQ/DRIeXIdGR5nBhL5i5fvDm
         WymdlW7p4/KRp2tklK7MgLgl233F1XhCQlAW9ilHrADcmCPsaKYx72gL6jrp0jewHik8
         e7KQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=G4kSsF7z;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=G4kSsF7z;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Message-Id: <20180201143421.088202488@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 01 Feb 2018 15:34:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@intel.com>,
 Ashok Raj <ashok.raj@intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Andi Kleen <ak@linux.intel.com>,
 Arjan Van De Ven <arjan.van.de.ven@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Asit Mallick <asit.k.mallick@intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/7] objtool: retpoline validation
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591210454988302775?=
X-GMAIL-MSGID: =?utf-8?q?1591210454988302775?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are the retpoline validation patches; they work with the __noretpoline
thing from David.
