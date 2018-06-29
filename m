Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC72C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC0628070
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1+xOefL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC0628070
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934526AbeF2VjI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:39:08 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34295 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752549AbeF2VjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:39:04 -0400
Received: by mail-vk0-f67.google.com with SMTP id l189-v6so1612965vke.1;
        Fri, 29 Jun 2018 14:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fHV61EL0StbipxsnXTGamvKYqWLKlaGdHLj+t6ZbxIk=;
        b=q1+xOefLojBzjhjPKHxQ80E6lBEOuv8Ou3BBirSjEDoLS/2mZHFxW1l0lSw+GgsDps
         2e5fqPkKGNFgx4EoRBDu2DdCo6sakGyfmHT75lOMIo8nSf3tCxPSoRKFRB28Ak6quO/Q
         r1HQVxmlZAjreMABP2uukj+YKNnasO4C6hdwHnIWAp7O0HfJ3jqHD9jmfqO4C6M80Kq3
         SROfC7uKWIXWW+j/Zk6//ojxqr7qn+8TmmQ45x2LNHXNHprn3F4/zeNKbRdLZj8sAs0i
         BRSpp57wyd1HDKTD3MXwjteM/BQyfJEPR37OBUEHF+9y6o4U6JOkKZy2DgK9NuYlpASE
         z3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fHV61EL0StbipxsnXTGamvKYqWLKlaGdHLj+t6ZbxIk=;
        b=PD18mKBb6cXfXpQ5icXcP1SLSDDIQ3vXLxsYy2JLDORFiZ8RsAjb+gvdrRRRSAxGhX
         rH5T63hNqxAQZLqTFPLEmqmVOzbgv/LzObsSyjs3PHlC02iEz/x+ZkwNX3gtVN7X3Cnl
         4DLYgqUx4rZQmLJBcvnfJKW8y+awrqhlHbifONW/MG3pky5b8cbXXPIptehd89VEW3J6
         Gq9himmYSkFimhURfn+F2CqhApbzItTKqXOeyb10C+rvcKEPzcCbqhlTy+FWyakD7GoX
         3G7cfoe7stEu9Cn4ffJN4/Z1ywCe3J7EQwX99A2urZ1W9z9/qD0nB+2leGHiU3Y/aMqq
         aVIw==
X-Gm-Message-State: APt69E3ew/0C1tmXjECmqAhdtewVaBTfNPhz6sTrQHZ93fVjvktRNW6Q
        dosfUkqirkODpGEGDG81oUU9ba/jGEbC0PC8NOQ=
X-Google-Smtp-Source: AAOMgpfngVAE2TTq+Ba0gpfqGKmeidAed35QbM+todyjV9HQtm73x2rQs382vu/DtwvEQQzYYcSv1OT8h6HmRzrW4lA=
X-Received: by 2002:a1f:a8d6:: with SMTP id r205-v6mr9834130vke.129.1530308344044;
 Fri, 29 Jun 2018 14:39:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 14:39:03
 -0700 (PDT)
In-Reply-To: <1530214274-21139-7-git-send-email-okaya@codeaurora.org>
References: <1530214274-21139-1-git-send-email-okaya@codeaurora.org> <1530214274-21139-7-git-send-email-okaya@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 30 Jun 2018 00:39:03 +0300
Message-ID: <CAHp75VcSapu6Q-eNhbbSQ6hSV=OF0pS=mXsdHZxascst5OLxCQ@mail.gmail.com>
Subject: Re: [PATCH V4 7/7] PCI: Handle link reset via hotplug if supported
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 10:31 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> If a bridge supports hotplug and observes a PCIe fatal error, the following
> events happen:
>
> 1. AER driver removes the devices from PCI tree on fatal error
> 2. AER driver brings down the link by issuing a secondary bus reset waits
> for the link to come up.
> 3. Hotplug driver observes a link down interrupt
> 4. Hotplug driver tries to remove the devices waiting for the rescan lock
> but devices are already removed by the AER driver and AER driver is waiting
> for the link to come back up.
> 5. AER driver tries to re-enumerate devices after polling for the link
> state to go up.
> 6. Hotplug driver obtains the lock and tries to remove the devices again.
>
> If a bridge is a hotplug capable bridge, bounce the error handling to the
> hotplug driver so that hotplug driver can mask link up/down interrupts
> while performing a secondary bus reset.

> +static pci_ers_result_t pciehp_reset_link(struct pci_dev *pdev)
> +{
> +       struct pcie_device *pciedev;
> +       struct controller *ctrl;
> +       struct device *devhp;
> +       struct slot *slot;
> +       int rc;
> +
> +       devhp = pcie_port_find_device(pdev, PCIE_PORT_SERVICE_HP);
> +       pciedev = to_pcie_device(devhp);
> +       ctrl = get_service_data(pciedev);
> +       slot = ctrl->slot;
> +
> +       rc = reset_slot(slot->hotplug_slot, 0);
> +
> +       return !rc ? PCI_ERS_RESULT_RECOVERED : PCI_ERS_RESULT_DISCONNECT;

Would it be better to

return rc ? ..._DISCONNECT : ..._RECOVERED; ?

> +}



-- 
With Best Regards,
Andy Shevchenko
