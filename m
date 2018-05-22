Return-Path: <mr.nuke.me@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527029525; cv=none;
        d=google.com; s=arc-20160816;
        b=HQAeNp46A7cO/G9thZQ3OUvib3xZuKwyddvf25J6z0Wj+iTbe6ZyyO7d1qjWbCwdDE
         MxZ9P0WOfO1vuU4Q1/Ye6VqSKspxfj3Ptv6jsdJz261zKTMJV1Y0//zo793WemslYwvg
         2dTWH4I9j9JBUyU6Za0SheF92hySC6vx6wSBgaBYu6zXaKLIgxwgOwYdl5Ur9d1v1PjM
         CGYO2Dg91u+gcNzz/rg5EpHaw3lQ/O2NNxQeU5brtB7wCYwhU0vE0gaQTo8SPHkxILNB
         De9oQpX3COHq4XZMwpo4HaIvp45AQy1Y8dRCMb6Entuf0ac2npX9dl9jHjiOTgndSX2T
         XINw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=nTHTR2+9eFbNHaK7jVialz5pvYXUwSCTOmnPjqSY64k=;
        b=fH1bFqcrCQDiU/6HrH/wB5IRAytmKfXfKsbZTzLnok0+WdaPSdsRIlHGY5SKgdV57M
         d5Gq5bX9HbboRp/Pw6KMSVxPIaBXMuKjxUcAGrZYzeawT1KpOzttJF8MNJOTNHTRSBrW
         IlHtVuiY+vZgqTrFEXqzy+slEpQDPyAfB3nOrevaulUZTxeXT14PXgdlA1RKOx3osclj
         On2GMBFTZu27wYcVeBMnE7nFrcj+sruok5hDr7KCKECchhbRaeBrtl+Y57TNcQr/JUr7
         FDuQJSxggJyJI4WCqp7H+FQlTaB1PUSBnhqXtYEi2yjm4ywhNKQ0Q01c0M8GoZPPYXzU
         9j3g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FpltDTxC;
       spf=pass (google.com: domain of mr.nuke.me@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mr.nuke.me@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FpltDTxC;
       spf=pass (google.com: domain of mr.nuke.me@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mr.nuke.me@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZomvtvXW4W9EmQo5uEWSnUtdO3qpyiFejU+46g9myDjtUvi2S1SxWEMu0FbterTx/tBdbX+Fw==
Subject: Re: [PATCH 5/5] Documentation/PCI: Add details of PCI AER statistics
To: Rajat Jain <rajatja@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Philippe Ombredanne
 <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Frederick Lawler <fred@fredlawl.com>, Oza Pawandeep <poza@codeaurora.org>,
 Keith Busch <keith.busch@intel.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Thomas Tai <thomas.tai@oracle.com>,
 "Steven Rostedt (VMware)" <rostedt@goodmis.org>, linux-pci@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jes Sorensen <jsorensen@fb.com>, Kyle McMartin <jkkm@fb.com>
Cc: rajatxjain@gmail.com
References: <20180522222805.80314-1-rajatja@google.com>
 <20180522222805.80314-6-rajatja@google.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <cffe5b81-a05c-a249-8c36-70a9c4d61e7f@gmail.com>
Date: Tue, 22 May 2018 17:52:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180522222805.80314-6-rajatja@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601205027389634414?=
X-GMAIL-MSGID: =?utf-8?q?1601206511941460446?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/22/2018 05:28 PM, Rajat Jain wrote:
> Add the PCI AER statistics details to
> Documentation/PCI/pcieaer-howto.txt
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  Documentation/PCI/pcieaer-howto.txt | 35 +++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/Documentation/PCI/pcieaer-howto.txt b/Documentation/PCI/pcieaer-howto.txt
> index acd0dddd6bb8..86ee9f9ff5e1 100644
> --- a/Documentation/PCI/pcieaer-howto.txt
> +++ b/Documentation/PCI/pcieaer-howto.txt
> @@ -73,6 +73,41 @@ In the example, 'Requester ID' means the ID of the device who sends
>  the error message to root port. Pls. refer to pci express specs for
>  other fields.
>  
> +2.4 AER statistics
> +
> +When AER messages are captured, the statistics are exposed via the following
> +sysfs attributes under the "aer_stats" folder for the device:
> +
> +2.4.1 Device sysfs Attributes
> +
> +These attributes show up under all the devices that are AER capable. These
> +indicate the errors "as seen by the device". Note that this may mean that if
> +an end point is causing problems, the AER counters may increment at its link
> +partner (e.g. root port) because the errors will be "seen" by the link partner
> +and not the the problematic end point itself (which may report all counters
> +as 0 as it never saw any problems).

I was afraid of that. Is there a way to look at the requester ID to log
AER errors to the correct device?

Alex
