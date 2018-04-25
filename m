Return-Path: <kys@linuxonhyperv2.linuxonhyperv.com>
X-Google-Smtp-Source: AIpwx496Y5H6RHnVAz08vatanuXU4uXMesOwwbEaWG/H2ogaL8SgP2Dwp6Div3r+a1Y5qxgJa0a2
ARC-Seal: i=1; a=rsa-sha256; t=1524679934; cv=none;
        d=google.com; s=arc-20160816;
        b=cVW7770WbIoRiafIe1fzOVHepAG5ACTWgcy7BfrjkCUvD9tNyX0+B/FVKZ4iLZp4IU
         1HOrYHKsZToDdzuAaJ3OGmAqPxnzpkl+zk8fQf2gzRw2gDcWzijCZFuUfrmoTncdorfc
         XF5C5DlYWhXrAGb+DRYZ/D2LS84F+Bum1Hj7qXggcdr5h8sHrodxeU9xKP7wtKkEptNs
         cXWcCYzM43zLtosj/Xqfl7cQk1V5LScuwodAH4WGR0AHyExkIw7Oel56UjmKTe2TFmVS
         6zWDBeyO+aW9bdrNhvId8Lev/h9OX/4b5Wchxl6VXW7XzbGFAwph4p8slyA1XW0WT3Vg
         vQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=L+G1wtfiCVa37v7BBxa7LBqGTAWvMVx78smy8VE0Z0A=;
        b=iWqBsAnHL42WaRLeXd6XjuOZQRgV1I6J31MgPMMRna/Xq+QSGES9mqun2bCtP5AY3T
         z6cRyqfV43qYOO03NY7hbDurNKKvT6pA436MSXzIxS3IuWYvRmteYtWyANHt9RF7Kdz0
         3TAj7d/BGYsOReNl7jZcPcfw2Ueo5526EEMExujcwbLrsOxkclVR3TbgEh7y0fYJ2IuJ
         NxriKrHekzYit9kpaFST2UJQ4LpCst7sIDzEYp/tSbxIcrca25kMJE0TxZPJJA2Z0Bok
         1cGbl8DC+B5Z5ADJ6Pv5n+UHJDcB3eP27rJ+JwZwAuStv7YE3LUGJZX1yt1HD1HViuam
         XqMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 198.71.225.38 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 198.71.225.38 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: x86@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	olaf@aepfle.de,
	apw@canonical.com,
	jasowang@redhat.com,
	tglx@linutronix.de,
	hpa@zytor.com,
	sthemmin@microsoft.com,
	Michael.H.Kelley@microsoft.com,
	vkuznets@redhat.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 0/5] X86: Hyper-V: APIC enlightenments 
Date: Wed, 25 Apr 2018 11:11:10 -0700
Message-Id: <20180425181110.8683-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfJR8HNBnJZ9AOD4yQi73WA/rSLNdjtsXDj+UoNBZBS7Kwnci77hGx0zuyGeqeiS2x3T2ppSQsStPyb/3eSJbQfA9MhPE1qU5C22TGFwWbcBUQ0gClRGC
 KeOdxdAKqi5aLhNmIJbkfAqq38ANynaHvA1RHWfx6lvZ/dsIjIdhZJYa1ZSSPUziR8XNPhGJGfG4Psza5y5aWRBV9gItZwmDn0UH7rnmVHjCMjAEfQYYv20p
 XlIDDuqDW6mORNc7daJhjOHPOQB8aHUbwocV66bcRP6HuLPnGJ8bwnDoRS6C5sWb7uC2jquY0oLapX6Dy0R03FYtToX02gducy/O2FFN/Ol6dW4xlWBOgw+W
 AaK8DXqfTNDnljx+ImBTJOLBXWTFGKaaBIDOf1VMFNz+L37TkqnQrN/qyMxEWn6bJkoTCEwqvZpnIYns0oHVlsmheIoJsFA6oNOz1Z4i9kbvSCtfCzc5CrI+
 vIYqWdh7SYCw/cOsEmwhmT2lVOCWRxuc/4rFz85u5hhUIfWqsDBPfI8GfU0f95a2S+DeCWGNJbDsn1lGVk7wgCjBjvAUY0WhTCIEDlKAX1G+C7Dxo0yZsOWz
 5G19L3TQlXYeGCCbn1uTFesa
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598742786635168641?=
X-GMAIL-MSGID: =?utf-8?q?1598742786635168641?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "K. Y. Srinivasan" <kys@microsoft.com>

Implement APIC related enlightenments.

K. Y. Srinivasan (5):
  X86: Hyper-V: Enlighten APIC access
  X86: Hyper-V: Enable IPI enlightenments
  X86: Hyper-V: Enhanced IPI enlightenment
  X86: Hyper-V: Consolidate code for converting cpumask to vpset
  X86: Hyper-V: Consolidate the allocation of the hypercall input page

 arch/x86/hyperv/Makefile           |   2 +-
 arch/x86/hyperv/hv_apic.c          | 268 +++++++++++++++++++++++++++++++++++++
 arch/x86/hyperv/hv_init.c          |  22 ++-
 arch/x86/hyperv/mmu.c              |  78 ++---------
 arch/x86/include/asm/hyperv-tlfs.h |  12 +-
 arch/x86/include/asm/mshyperv.h    |  47 ++++++-
 6 files changed, 356 insertions(+), 73 deletions(-)
 create mode 100644 arch/x86/hyperv/hv_apic.c

-- 
2.15.1
