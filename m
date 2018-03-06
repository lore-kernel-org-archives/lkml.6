Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3088149-1520301480-2-624614031239487922
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520301480; b=CkVi0BWNO/fVaymahiCanGi7SGd+Dvc4BBaAJf60QH/aPY/
    mRpJqRAVlEk/1FFa/tVFr55dhSlG2bCh3UO0FY5ZzJy9ezywtC/3ifhTtFtXRn/k
    7S6cVhBJaEfRlzi1XXFLHqsD8RR5p176nBfdBBpFkaHErs25MdEhQwlfOH98D/t7
    8V+CAAGLUNlHPBKMI6YGQPh6GD9mMJElLwNpIEAf7mQAIKBFU/2Wf93zITSLpdFT
    N2WdT87j4aCaVi7QpzyukcCrg/vYs3g+qsZsZqM9ZyK2p3TweNwfQpfzPXoV01jh
    dF1t0R4KP85OCejrRcDrx3ZSxv6mRbKyEO8nXXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520301480; bh=+7Np9xIQ9bXMLgnOs6RMFeBC3r
    ybnF+gbAa+qDp6Crk=; b=R4ANdvcJ7fQzzbjyd6+THHwGIzsLzMZngrayAKwPf3
    NvGsDDQS+HDOjm0K+13xbC0u9yuCxQCDvttxpc7FsgypV79Fw8Y71zNIe9EeLBQj
    CAYz1sIQJw93vABsX19KcDDu23+e7Th2A4Wq6GNaxKhpXAIdhwIqYGTRLTF0uLl0
    2lSql7p4nti2QJFnPdvf1CE4mNTFa54at4PHFHRy+qJEQAmIjTC9PLZ+9leOPDEZ
    04wLgTlo+XtD3rq6bbWIsvgsXVlYMmmwk8i+KA7gZynmCBVGrIuRqxu89Q6qMQeT
    Qdf5lAFPEBThS8WBPItuTrUV6IAGnWBQWe+sMl8ocn6Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BQBz78/A;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BQBz78/A;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752894AbeCFB5q (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 20:57:46 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39346 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752440AbeCFB5o (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 5 Mar 2018 20:57:44 -0500
X-Google-Smtp-Source: AG47ELvP9cli6iiFqJ1Tsb7sY6LOzaZmfwIQ0nxJQywRFYX2MuuF28+pWgRy+btTTpUxFseglg2oJA==
Date: Mon, 5 Mar 2018 19:57:43 -0600
From: Rob Herring <robh@kernel.org>
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Alan Stern <stern@rowland.harvard.edu>,
        Roger Quadros <rogerq@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: ehci: add optional external
 vbus supply property
Message-ID: <20180306015743.uazy4e5quil2ijy2@rob-hp-laptop>
References: <1519897899-8577-1-git-send-email-amelie.delaunay@st.com>
 <1519897899-8577-2-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519897899-8577-2-git-send-email-amelie.delaunay@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 10:51:38AM +0100, Amelie Delaunay wrote:
> On some boards, especially when vbus supply requires large current,
> and the charge pump on the PHY isn't enough, an external vbus power switch
> per port may be used.
> Add portN_vbus-supply property to usb-ehci bindings. As the number of ports
> depends on the ehci controller, and the port on which an external vbus
> supply depends on the platform, <portN> is used to make it generic.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-ehci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> index 3efde12..cd576db 100644
> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> @@ -19,6 +19,7 @@ Optional properties:
>   - phys : phandle + phy specifier pair
>   - phy-names : "usb"
>   - resets : phandle + reset specifier pair
> + - portN_vbus-supply : phandle of regulator supplying vbus for port N

Just make this an array with the index being the port (and drop 
"portN_").

Rob
