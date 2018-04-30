Return-Path: <mr.nuke.me@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525110088; cv=none;
        d=google.com; s=arc-20160816;
        b=RL4zNKiPzl6l3uH3/aHQpUnIhr07UgJ0qXOIokW7728z1EaD+71s/agCbwnZkHQyXF
         M7pRNsWmNEVB12wZPKdlXR5nSQ01UgjfqXmSj3lzOVjMAzyjXFz1yAGB29rUR9pz/VX7
         I34rAtlj6azREfAwRXYRTxoIwoEhWFxt+wDkgHv1HI96naccsNzuDf0hc1ioHljmwOIA
         krnUTM9qB4FGWpvPe5nOvREGHg8KDruP/D+hBFxL2rSTYuWQpEnaUj8sgwDrQZF2m5PT
         hDEsa+xAJcxzT+1cel1c/S4rDB5mUn6VMesVAIwaGbOug+s9f4gVeDnF5r0F8TNm6L3h
         YkAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=uLfQqqkI98fgsIspshT/SVJb0OerH4QAhj+gdzXY6B4=;
        b=XOwHnliztw88+VskL6uT1W72E9QEsa1ASnW/Vl8jKfRrfxQiUtBz4r9PYC8iPmrYZY
         EDnWVIFNw5Vs3ToSPxt1mUf25UlfrL+KxMXQpRDymc94yQfFQOJdckS5vqm3cVMlwLnZ
         5VQNteN1YVUBKjU8RyrecMMELMSR5tqwUJaqm7nFhIJnP2CjyPKMHOvzUVaeOEw2ZNYh
         0CMLXzafiNZask04Zu96XBsyT4oQ8YKhZ2Fzmo/nq6KdWG99tqj/nw1K9CF3d+NKLjoX
         ZRq2grRMAvFFMnG1o1E28zBQz7TINPsCkPOV1ooqh8tmoYy4FoK06bJcLK8MPgqfbRzZ
         NJtg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=D3EtrySR;
       spf=pass (google.com: domain of mr.nuke.me@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mr.nuke.me@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=D3EtrySR;
       spf=pass (google.com: domain of mr.nuke.me@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mr.nuke.me@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpJm47/Sdoxnbm+t55dh+gLIkbXN2yJg9En71u3plhMc2GqExtuIHtYBNHlcHene8CC1Wmk7Q==
Subject: Re: [PATCH RESEND] PCI/AER: Use a common function to print AER error
 bits
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org, fred@fredlawl.com, linux-kernel@vger.kernel.org,
 alex_gagniuc@dellteam.com, austin_bolen@dell.com, keith.busch@intel.com
References: <20180417170943.1767-1-mr.nuke.me@gmail.com>
 <20180427224337.GC73256@bhelgaas-glaptop.roam.corp.google.com>
 <12343e44-2d8a-51e1-a0be-e6804e9bd8a3@gmail.com>
 <220bb125-b933-abf3-7b30-63446634e8d6@gmail.com>
 <20180430171531.GB95643@bhelgaas-glaptop.roam.corp.google.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <8e8a8de1-a90c-ab88-c8ac-bbe8bcc7d49c@gmail.com>
Date: Mon, 30 Apr 2018 12:41:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180430171531.GB95643@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598014086120567687?=
X-GMAIL-MSGID: =?utf-8?q?1599193836183343381?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/30/2018 12:15 PM, Bjorn Helgaas wrote:
> On Sat, Apr 28, 2018 at 12:07:48PM -0500, Alex G. wrote:

(snip)
>> I could update the offending line to say:
>>  +	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
> 
> That's what I would have expected.  So I'd say either do this, or add
> a comment about why it's not the right thing to do.

Okay.

>> Though I still have the concerns with validating CPER data:
>>
>>> I can see a way to use even more common printk code, but that requires
>>> validating the PCI regs we get from firmware. That means we need to make
>>> a guarantee about CPER that is beyond the scope of this patch.
> 
> Sounds like this is material for another patch, but if/when you do
> that, I'd like to understand your concern about validating the
> registers we get from firmware.  Are you worried about getting
> incorrect register contents, then printing the wrong info, making
> the wrong decision about how to recover, something else?

I don't trust firmware, and I have daymares about firmware leaving these
fields uninitialized. In jargon, I'd like to treat it as external
untrusted serialized data.

Alex
