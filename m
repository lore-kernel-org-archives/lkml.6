Return-Path: <SRS0=KIOc=HN=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AIpwx48PBzQcH+VYIzuNw9zIxgbNWxKR9lsOkQCmRgOxXplFzenUa9NMpicQC+D7C1u/Tars4be1
ARC-Seal: i=1; a=rsa-sha256; t=1524595861; cv=none;
        d=google.com; s=arc-20160816;
        b=uhHgAmoO94ERWwVAlyDNeltthkZZk3/qHinHLgGeOV5DeYAOG7h1xHyUkSfvb2lsrP
         H6fqECa0rsLHzvnHmrDGRIUVcL+UTpGj5FwBOuboWq5oQBzoJyAYOXoAkx/Tb/sFotya
         P2v+HSXB/P6lUHLpSEU0r66EauVypz1a6Lh0GqxFFftGYELqWjpWIPzXgx6lvg7orSWT
         Y2zMDx+Br3IrecZ9hArTjU9KWzui1uxrG1i1WYdA7rTbQDekfiksue2XGmUKUCwFak0q
         Ds8yHMnV5P1YisC3yhPya+wObxah6qdrnmLW5DTMUTfhoErZ3jKk5jcri02auTviYwON
         HCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=dGpZ7kg9HRSiNG4mxwe1Dhyz3TiHbkTsHwBGGcpzOkk=;
        b=aULuhVMM2YxBkSNTbDVEjxzZfYijOQpKwHEwfEbaz7yDCLHN+UTAJyDcMF01KPIgQs
         +kCDJxVN8mCevOmfeZKRmqSVe6KEVhHRowL4lbxDjV8Y0PCeiqyN/OZfsU48Z2eV+fic
         QD2hBYhr6mVx4E2fd3YCCnGL3tf5X3AgxVFTlkMizhIevujDjhygPTX/t4kcI/a2R/Or
         IJWCrB6fEr7ube6x7geYqi4e7xTzgz1z9pFJ2au12oaqi6c4vHS8mV++MY3VApjIAREz
         OY7mBIZfxswEysIy/ppR0nODFvUdXWczJSrseHNP5OfDULjo5W0e2kslPD8QX3RjeAXK
         B9GA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=kioc=hn=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=KIOc=HN=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=kioc=hn=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=KIOc=HN=goodmis.org=rostedt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF37D21774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 24 Apr 2018 14:50:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wei Wang <wvw@google.com>
Cc: gregkh@linuxfoundation.org, wei.vince.wang@gmail.com, Ingo Molnar
 <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook
 <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Crt Mori <cmo@melexis.com>, Alexei
 Starovoitov <ast@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] do not call trace_printk on non-debug build
Message-ID: <20180424145056.7c29ea18@gandalf.local.home>
In-Reply-To: <20180424180812.215900-1-wvw@google.com>
References: <20180424180812.215900-1-wvw@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598651942651560845?=
X-GMAIL-MSGID: =?utf-8?q?1598654629633907463?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 24 Apr 2018 11:08:10 -0700
Wei Wang <wvw@google.com> wrote:

> From: Wei Wang <wvw@google.com>
> 
> trace_printk will cause trace_printk_init_buffers executed in kernel
> start, which will increase memory and also show bad warnings in
> production kernel.
> 

NAK!

Where is trace_printk() being used to trigger this?

trace_printk() is to be added while debugging, but one should not need
to enable DEBUG to use it. But it should be removed when finished.

-- Steve

> Signed-off-by: Wei Wang <wvw@google.com>
