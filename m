Return-Path: <keith.busch@intel.com>
X-Google-Smtp-Source: AG47ELsabmkAChm5wYpU9evSSuLqPq///+6/Z+n5QHEmWe9Vr4kiT+72BrqzYW+VdGadDh6FKB2y
ARC-Seal: i=1; a=rsa-sha256; t=1521060632; cv=none;
        d=google.com; s=arc-20160816;
        b=gAX5QR2rXtNSoU/Wo48lcFkAnt6tVsVOzcVC0mYxrL1Oh641Wn292+7l4qnBPk8lHk
         M4Ii/g6MqEyChEHwBCqn6uzm9dZnDNnmU4KB737An2nkupK4sUHChu472DzVNUlrUzbi
         KgpHrRsUxJxk12hoZCTtPrrmSnOxJT66JLC6r+fHc7w63KmgCp66i7uS4OOF+/QspWUO
         yZnIiPf7Ju4nctDco8+CdWAVlUoPtUwf7d5Re88zFITSgqJlK5haccLGlsPrPNQY8yn6
         tw44GHc6pzvsJ/g7DUYV2VT/PNzqGVxI4f+VsDmTvfrB83H1dNk6kMJ/8JcOpY53w0Uz
         voWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=KxHDhWoQx3iZ8tQvHLkZSmKX4VxH5MfBfulFzxDvuYY=;
        b=YqNMnV4e4pwrEtBMuiNkXFkfzxUfgga0gbIaxtH2qgZIADgRsgIr9shU/Q0H+DwGUj
         I9PeoaCkcSovuSB/WBG2eUeG5m+vnlJ3ZYgpr0FBqN70CjNXjIAyQlp21GEZpjFcDg1C
         uNfnLi1c0uhoDxYPFqbUaeOhO9Wz58UD6xh6J0h9mtHXhzMUPOwR/wkQeK0v+Yrddrsu
         3dWOrrDsgO9VYT4NyCA15ZVziHjopcaA/vDf8eyFbr/OuYXfAm8myQtgi0qrlPZe65WM
         4ch3tyJXY/tEsQv6KvGvwjJULMFsuLjzxijwDUX7gCRSw5Kwq9NmiB403buXq9FAmKga
         1FAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=keith.busch@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=keith.busch@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,307,1517904000";
   d="scan'208";a="25310712"
Date: Wed, 14 Mar 2018 14:52:30 -0600
From: Keith Busch <keith.busch@intel.com>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>, Wei Zhang <wzhang@fb.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v2] PCI/DPC: Fix PCI legacy interrupt acknowledgement
Message-ID: <20180314205230.GF29867@localhost.localdomain>
References: <1521042648-20522-1-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521042648-20522-1-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594928862601446730?=
X-GMAIL-MSGID: =?utf-8?q?1594947674063038266?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 09:20:48PM +0530, Oza Pawandeep wrote:
> Current DPC driver acknowledges the interrupt in deferred work, which works
> since MSI are edge triggered.
> 
> But when MSI is disabled (e.g. pci=nomsi boot option) port service
> driver falls back to PCI legacy INT interrupt.
> 
> With current code we do not acknowledge the interrupt back in dpc_irq()
> and we get dpc interrupt storm.
> 
> This patch acknowledges the interrupt in interrupt handler.
> 
> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

Thanks, this looks good to me.

Reviewed-by: Keith Busch <keith
