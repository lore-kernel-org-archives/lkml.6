Return-Path: <mpe@ellerman.id.au>
X-Google-Smtp-Source: AB8JxZrPC4vxRhZk/a8EX4ICllXapQ+i5mb85OLdyIyA/PU3Z+h5AekwzbE6qy6yLpfCV0LkNBeT
ARC-Seal: i=1; a=rsa-sha256; t=1525411009; cv=none;
        d=google.com; s=arc-20160816;
        b=Ka7mqcnI+v6GzKtOkGVl4gRYMlYj0wG4pKGuuwheqxUWW1hVbWwRZtUncZWuC1jESG
         dC1iNXvIpyB1S8aaXAfrdbOJKSXFWRtSkJfMWyWxi2s6YzGSzsgks+q+lamOiOD3mgyT
         4O3nSIbiz/4qicIbesztjlCdAG9EmkTIQb1Ubs5sKxI0oy8hQl9q7WfPpMsr5Ge/OuST
         +LMVGb2iHNqEezVfvOzpumg4bZ7srY6h3uFf349QNeqUyeK7RFZXCSomJqHwd1NOCFd8
         d9PEwk3eula644JC6UANnEKiYwjj9JUKTmpztucv7mRBYAwcwUMLN0MyvZ35/PMh38hd
         i8aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=y1VmhAjGWJE4X/8MyTt1HOKuHBNHNBtzJmn4AgyDf7w=;
        b=OM7/Al9URMdToL3fxXAlCT2YxibnKnZwtM5ayvfM6Zp7eBFHlWLpQmloZzlgJTjB4A
         XKY18tdCmheD/7IUNCIINa2akSeAEJ/woNkNPLTEI1VuG8QHxfiS/dqTD5Q9MUez/X6v
         RuHuynaqdZkHgVRihlFLEFvhA4sujq/OtESsqURPxurTF4NGe+UBmpqGZ3K2O0wlYm7d
         vNQ2nqdpSIJ9AOSycMUdMxcPfbSOOuilTU3IUJ0ZvzPNb8xukEbsMn76QvUvDzqimyG2
         DPaME5g4OfvaFSu4e4jh+vOevt3fWKzk2yp8C4q2AJV61Q2p3/TC3PccXeG59G15I8nx
         UQHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2401:3900:2:1::2 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2401:3900:2:1::2 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/15] powerpc/powernv: opal-kmsg use flush fallback from console code
In-Reply-To: <20180430145558.4308-5-npiggin@gmail.com>
References: <20180430145558.4308-1-npiggin@gmail.com> <20180430145558.4308-5-npiggin@gmail.com>
Date: Fri, 04 May 2018 15:16:37 +1000
Message-ID: <87muxg80ga.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599183451122520462?=
X-GMAIL-MSGID: =?utf-8?q?1599509374612792752?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Nicholas Piggin <npiggin@gmail.com> writes:

> Use the more refined and tested event polling loop from opal_put_chars
> as the fallback console flush in the opal-kmsg path. This loop is used
> by the console driver today, whereas the opal-kmsg fallback is not
> likely to have been used for years.
>
> Use WARN_ONCE rather than a printk when the fallback is invoked to
> prepare for moving the console flush into a common function.

Do we want to add a WARN in that path? If we're panicking things might
get worse if we WARN (which takes a trap).

cheers
