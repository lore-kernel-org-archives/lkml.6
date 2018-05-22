Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3081717-1527020456-5-4777360675805260319
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527020456; b=HOKGjc6H3HrN3nATtxgZC/ygVkMwT5twhZmXsntr37vq7xYDoE
    b2Vf6LsnHai08BZdMRgoay8tiWVPA8tUdKXMK1Md9DYCxAKoWvhQnGZk+O22tjgS
    aT4tiOROtz89pa4jAkQiHmq72Ipdl35TjYli2QvmAht155DmhR4ZRt4+7+o/J/ud
    z9Wfd15Inxueg8MaE+GHlhd4LXy8so4h4hz8TM4KcU7JtHHRjc5C/3mp2h1/GLBy
    P7xSsDPkCeMoS86t5qg0hzVTmFLLHrZyJJYDSMbwGXNWOS+jK8nk//dWxqm8hcY9
    1CH6wgQy28dNptk5xmRs3gUamUGccMus3nuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527020456; bh=FJrHodYbul9BITS3RnMDHIvQPFMlrF
    czf4Zh16n1900=; b=IIiZztpf2SJl5aVtpY6G72EQdmBO4XE6DRH4jGIZuj5fIm
    5YsenJ/JJJUiUDJpR3d1atr0WFc6/x1De2qlWple/P1cLqKwpMOIgtNhUyj5SYbu
    Kd//JCMmWwv1qy4D7J1l44GrfxlhxGvQrr5VkT7K5x4TweEaZDK7Jj/+u0mN6GOr
    SldlwM4ORGc4N/3RidkZmW1TfRBC8UVgY5FXG6ZuT8EFeAJh7TlYWMoBxcUEhaQ9
    YJInJD/q9qTWm8hFPUDf2Q9oiIi8XTNIywodgVPPJlBdXpWSsXAO8F15DfIElELi
    rUN4kCk8GhRRAhGpavXMk98ANMZgWzWiscs3Iwjw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=YasIDizz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=YasIDizz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH4xbF4vAKu5WwhhzyV4LGpDEHkN42P2ez1gxLzMwamz77msuodfQyIut3B/eWKdppBf25jWFmSqrlWb8cqVFnfqYTZjDp8bzbNT0bykLlEvrl4CyugD
    3HAHOm1KILV3umCjaSW8ZpBtQW5qcs8KgAPv1zyrDxTqHBPmk6SYX0+MqNBPPlqRrY14Q3Xgmd3ub6goOiQMWwxxK7ofHACrvjr9oTiApU0hMbe/ca/zLTCs
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=b1CNDAZ_6rHJY3lQFZQA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752329AbeEVUUk (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 16:20:40 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34694 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbeEVUUi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 May 2018 16:20:38 -0400
X-Google-Smtp-Source: AB8JxZrWTetcEmxf+Xe0YmIFEVJsJ/e/ZzfrfMKLwb6XcRivwgr311ylFLlVVNvjFu0KlaW6CUEaBA==
Date: Tue, 22 May 2018 15:20:36 -0500
From: Rob Herring <robh@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: mark.rutland@arm.com, jassisinghbrar@gmail.com,
        gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, araza@nvidia.com, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: serial: Add bindings for
 nvidia,tegra194-tcu
Message-ID: <20180522202036.GB24611@rob-hp-laptop>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-3-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508114403.14499-3-mperttunen@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 02:43:57PM +0300, Mikko Perttunen wrote:
> Add bindings for the Tegra Combined UART device used to talk to the
> UART console on Tegra194 systems.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  .../bindings/serial/nvidia,tegra194-tcu.txt        | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> new file mode 100644
> index 000000000000..86763bc5d74f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> @@ -0,0 +1,35 @@
> +NVIDIA Tegra Combined UART (TCU)
> +
> +The TCU is a system for sharing a hardware UART instance among multiple
> +systems withing the Tegra SoC. It is implemented through a mailbox-

s/withing/within/

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +based protocol where each "virtual UART" has a pair of mailboxes, one
> +for transmitting and one for receiving, that is used to communicate
> +with the hardware implementing the TCU.
> +
> +Required properties:
> +- name : Should be tcu
> +- compatible
> +    Array of strings
> +    One of:
> +    - "nvidia,tegra194-tcu"
> +- mbox-names:
> +    "rx" - Mailbox for receiving data from hardware UART
> +    "tx" - Mailbox for transmitting data to hardware UART
> +- mboxes: Mailboxes corresponding to the mbox-names. 
> +
> +This node is a mailbox consumer. See the following files for details of
> +the mailbox subsystem, and the specifiers implemented by the relevant
> +provider(s):
> +
> +- .../mailbox/mailbox.txt
> +- .../mailbox/nvidia,tegra186-hsp.txt
> +
> +Example bindings:
> +-----------------
> +
> +tcu: tcu {
> +	compatible = "nvidia,tegra194-tcu";
> +	mboxes = <&hsp_top0 TEGRA_HSP_MBOX_TYPE_SM 0>,
> +	         <&hsp_aon TEGRA_HSP_MBOX_TYPE_SM 1>;
> +	mbox-names = "rx", "tx";
> +};
> -- 
> 2.16.1
> 
