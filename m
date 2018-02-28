Return-Path: <eli.billauer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519819220; cv=none;
        d=google.com; s=arc-20160816;
        b=nkqVyg6uBIb75m3ElwXT2mRmzJlxkqAsG7G5qenUqTX1ZcfZupSR3RVcefvZTiuwxn
         OpmRrm9Y7WGjKOccQjagUh/+iAOG2paSgKcDQlAvX+PznHtOUyOhpCdK/qx07alCOrId
         vWWR+gip+8XPKESkq+f3Ge+PAZQBCc70m0/YLK1mf5KYjzkDNwV/N8G3gi49/88w8tPe
         DjCygKRx98isIM5ed6IU9xAv4roYSYQX4jWWtbgnILcVDgyrTtfQJfMOzZ6eNOEMk8Sz
         rHU1+26KOLqme1nGkIYRBJyAdWZlJMCSKu6LPMHN4rnEfze/SG+jgR3USXVzcxhJ1+Wd
         uV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:references:subject:cc:to
         :mime-version:user-agent:from:date:message-id:dkim-signature
         :arc-authentication-results;
        bh=A6l+zeiMBKQw6FpYFUuJIUUQ9rVJybi1lXGHDtUpxyQ=;
        b=r8EpFBwIoo/ifHXLzFtg7XHV3gDJcpNtkzgUOb3ZGXAFYRMg4/qBWdE420ggnEDtmY
         nQiZtBPgkzajh5UJ7dnZl5kM+F/BIFNbHU3A2cNWtZ/tDUHUGkNrCFN2L7W/+wv1HTqj
         r2CCK0SKE5MiYNG9Hjkp7+y3Zkl+JNESy0F37ziHfkiQhgslGthyWNwu7H8y33RUNcJF
         rBW/1HVGPhdU24XBGpfNu79O57QVBWi7glzENBSH/Vl6HNdkGCoVZL+H4xeI9y1TZyMx
         uSAAKmTHkJ77pW7dFJRimQofq2RTO2LkUtLttfcDAcQ26YlWiG2anq5VB+IcUNCsdu0o
         YIRw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YfnoYHeA;
       spf=pass (google.com: domain of eli.billauer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=eli.billauer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YfnoYHeA;
       spf=pass (google.com: domain of eli.billauer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=eli.billauer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvBSp/doJfKYnnvXETQCCjyTWzln6yRdnM/8OBx48kK5pnqbB2dOGzCkc46I74VZGsz/DHs8Q==
Message-ID: <5A9699A7.6060801@gmail.com>
Date: Wed, 28 Feb 2018 13:59:35 +0200
From: Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To: Johannes Thumshirn <jthumshirn@suse.de>
CC: Greg KH <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <helgaas@kernel.org>,
 Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
 Michael Moese <mmoese@suse.de>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2 1/2] PCI: add vendor id for Altera
References: <20180228084418.7566-1-jthumshirn@suse.de> <20180228084418.7566-2-jthumshirn@suse.de>
In-Reply-To: <20180228084418.7566-2-jthumshirn@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593633633648398473?=
X-GMAIL-MSGID: =?utf-8?q?1593645959206710812?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks.

Acked-by: Eli Billauer <eli.billauer@gmail.com>

On 28/02/18 10:44, Johannes Thumshirn wrote:
> Add the Altera PCI Vendor id to pci_ids.h and remove the private
> definitions from xillybus_pcie.c and altera-cvp.c.
>
> Signed-off-by: Johannes Thumshirn<jthumshirn@suse.de>
> Cc: Bjorn Helgaas<bhelgaas@google.com>
> Cc: Eli Billauer<eli.billauer@gmail.com>
> Cc: Anatolij Gustschin<agust@denx.de>
>
> ---
> Changes to v1:
> - Remove redundant pci_ids.h include (Andy)
> ---
>   drivers/char/xillybus/xillybus_pcie.c | 1 -
>   drivers/fpga/altera-cvp.c             | 2 --
>   include/linux/pci_ids.h               | 2 ++
>   3 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/xillybus/xillybus_pcie.c b/drivers/char/xillybus/xillybus_pcie.c
> index dff2d1538164..05e5324f60bd 100644
> --- a/drivers/char/xillybus/xillybus_pcie.c
> +++ b/drivers/char/xillybus/xillybus_pcie.c
> @@ -24,7 +24,6 @@ MODULE_LICENSE("GPL v2");
>
>   #define PCI_DEVICE_ID_XILLYBUS		0xebeb
>
> -#define PCI_VENDOR_ID_ALTERA		0x1172
>   #define PCI_VENDOR_ID_ACTEL		0x11aa
>   #define PCI_VENDOR_ID_LATTICE		0x1204
>
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 00e73d28077c..77b04e4b3254 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -384,8 +384,6 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>   			    const struct pci_device_id *dev_id);
>   static void altera_cvp_remove(struct pci_dev *pdev);
>
> -#define PCI_VENDOR_ID_ALTERA	0x1172
> -
>   static struct pci_device_id altera_cvp_id_tbl[] = {
>   	{ PCI_VDEVICE(ALTERA, PCI_ANY_ID) },
>   	{ }
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index a6b30667a331..6a96a70fb462 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1561,6 +1561,8 @@
>   #define PCI_DEVICE_ID_SERVERWORKS_CSB6LPC 0x0227
>   #define PCI_DEVICE_ID_SERVERWORKS_HT1100LD 0x0408
>
> +#define PCI_VENDOR_ID_ALTERA		0x1172
> +
>   #define PCI_VENDOR_ID_SBE		0x1176
>   #define PCI_DEVICE_ID_SBE_WANXL100	0x0301
>   #define PCI_DEVICE_ID_SBE_WANXL200	0x0302
>    
