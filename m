Return-Path: <BATV+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AH8x225a8UxtFQSwb7JBlGIRduLtIHY5T5pN7EBXKJ79V0eCUpuhu5C2xPdDbYSYo4CeYnhmeyrn
ARC-Seal: i=1; a=rsa-sha256; t=1519324565; cv=none;
        d=google.com; s=arc-20160816;
        b=bdCmnqwVk+m7tmcekWq72qoRQFEQyDo0+dP+g3fBzIxvNtQ0M0VGuZ/+YZMvhUwaLz
         iH81f8xdE/ii2EBnHkqP4apJ70RNqrGVYKcDudRRHjlerp2hn8fG5/boKN9MZdrSkHPD
         7QUWtIZB38OdRlclFCJDtefz5heOiP88irYE/3GeKMnOqoprMafk03mTXSi9TsNly2w+
         mxU9rWD5mMix11L4/ENXU9zm9iy+ZdEUG6nmUDyoJ7alizV2fBj7GgcPeGRo4qwku9zN
         8lTnOhAmtL8NakqD3rtJEDaJR8gtrkJjN4jP371AI0GH1txhqL7aTDVVpLe7Tjah0eKB
         UejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=STRXvZ8n4Xky40cfYtZN68uFpKMj0eXb7TKmdZUCnHc=;
        b=aqnqJLhIqvv6MDoAvU2WE8gFuJmhsYd4mSPTXcGYN6OSSpsQp/upgX2D/k6zNnh8JV
         qJG08MIHjgwnSCBdkpJvI6CVYqSwcW3p4Rm6Y/2fUUcqUf14YvwkZYq0oKvzfq1CzNXf
         EZMDI+Obz7m2JJDiBYSw0NKn2ZKioaZirb9K4SQlZ81GKKJ3rznfqqlqBDvljONJDrLi
         hbUyTBIjysgxEvKPriddZuMvMT7EOp0uu6cxcEBUAxLRMmG3J3lxQB0mtof3gTT4pU4o
         wbyE7YWdUwSFVYmzQVdYi+XmFg5h22T7g9/qpzFVB0i7PMtJ9KELW4EY2t7pGXIi/DSa
         KyCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=dbgbm7cK;
       spf=pass (google.com: best guess record for domain of batv+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=BATV+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=dbgbm7cK;
       spf=pass (google.com: best guess record for domain of batv+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=BATV+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org
Date: Thu, 22 Feb 2018 10:36:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>,
	Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v10 3/7] PCI/ERR: add mutex to synchronize recovery
Message-ID: <20180222183602.GC6267@infradead.org>
References: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
 <1519315332-26852-4-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519315332-26852-4-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086412177501980?=
X-GMAIL-MSGID: =?utf-8?q?1593127275215628172?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 09:32:08PM +0530, Oza Pawandeep wrote:
> This patch protects pci_do_recovery with mutex.

Do we really want a global mutex for this and not one per root complex
at very least?
