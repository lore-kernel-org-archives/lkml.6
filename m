Return-Path: <kys@linuxonhyperv2.linuxonhyperv.com>
X-Google-Smtp-Source: AH8x226XUIOeHzVkIAbvTAbXjjodnh05IpbYNLmrusLcDVPG3RQsacdn/XarTPbXfSCuOCduIxi6
ARC-Seal: i=1; a=rsa-sha256; t=1518395475; cv=none;
        d=google.com; s=arc-20160816;
        b=ddnQOAFaSnVQHRsJLtRLTBHHKmYdNBN+W04lG7QdAlf9kZLd5sWsyZR0QwvE4cJAkX
         42/D/Zpu77s6o+lAQBnzWQnXkc2/6RrwKqywFMPTcPMqeCITj5Ch+diur5bFLZaYohvJ
         slWxaxPhAVRHQ/i6SF1NUKxgRssoy3I4wQjtALh+emrL1wQtvT7sFQqA8nzxWnWDXbGC
         qycW8YLadlkp/139A4wH41RoBfIWWiD49KRPZuvCM45a/sf1i51unIpXcw0ZN2XFTfK/
         0twC/lDlniUZ2ffKRxpky4ZbM2hQX8tPY/RtWqs0rLWQtXQiQxq9uyyV1LePsscsa/wc
         l1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=qnhWfuIrj3DkNo920LjMNW9N5KM5A2rY/zpD7QonNOw=;
        b=fcOdvz+p9nSzZgno//jqM1RlahnVu+E6fIQ7+MKmTScZCmsQRUt+RlyQrGIVjMC75Y
         QFnM45RwX9T8T4QcrcxvX7Wu9mavZvwqBGcCaivKkWy1ubs2jiPt++11DnLMnWM/i3Zh
         4vi4q5PY/5hq0ccQONf4e/hHbkc7D7AqMSNIg6y61qtJ+CiiONbxqEkw7zjj/+ezkhrO
         P+7OQpXP64603KpjqzEO0uyyrRM3HP6BqVSl/meG/wgpAlYGjSYt31AmIj1nut0uj1xQ
         rlwOB0S/7lVm3Gl0ogo7hnQ7BzSgXuLIMcEVXrBPW8YDMDdOlvYWxIR6/ZaGnaPaLW1M
         d+oQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 198.71.225.38 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=exchange.microsoft.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 198.71.225.38 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=exchange.microsoft.com
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	olaf@aepfle.de,
	apw@canonical.com,
	vkuznets@redhat.com,
	jasowang@redhat.com,
	leann.ogasawara@canonical.com,
	marcelo.cerri@canonical.com,
	sthemmin@microsoft.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 00/12] Drivers: hv: Miscellaneous fixes 
Date: Sun, 11 Feb 2018 17:29:58 -0700
Message-Id: <20180212002958.6679-1-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfIh1LvsUNHsw72Cmmjeq2ofgEV/zxT8dLfG8zY4boiodk1ZqGgVRGoWy/eByVnV0oP3yt+WzhZ6egWLT7gCpJvpPjfILtaqKCegRYh/bJaO1bkh5dSyN
 wl/O8vebD6pQPMD0GDxRmC4mcF0aZW7KfuFrXFvRI/R1/53JnNETvhXs7ihKXxUxj8UQIT6MaQ5MnXf616c7kPdoXlJ84HORPL3Q60yw0Re+OjonHH98aml4
 P353Rhg6jQ/kTa+j7GDeeuzsqd6u7iptjvogTys9Km0rkko9W1snPjCskguMt5YrLg6f43COTZu7RYA7SXdiIvuXe3kmpXUPCT825TMgxomPHtb106z4lOK+
 qNaIah1/GPrnYiV2JwAeewzWDd8brzNduIdiAJTBX6jkSoMGjT57uQJnMFaAyIhxtlOExwAmZYkzJQ2ee46ilHgPbVB0o93ztkltdkIpB4zweQR3m+Xm6YOJ
 sRMIgE/Yr4VfyIwyeQciNwlkc9XEcaPVsqG/Fdc1JjMoJwInNYn0HvwH+DMIa0i12S47T9TS3rr1t+18jmb9TGkD1Tk5PQfqyKEZfw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592153053742572910?=
X-GMAIL-MSGID: =?utf-8?q?1592153053742572910?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "K. Y. Srinivasan" <kys@microsoft.com>

Miscellaneous fixes.

Dexuan Cui (1):
  tools: hv: fix compiler warnings about major/target_fname

Haiyang Zhang (2):
  tools/hv: Fix IP reporting by KVP daemon with SRIOV
  hv_vmbus: Correct the stale comments regarding cpu affinity

Jia-Ju Bai (1):
  hyper-v: use GFP_KERNEL for hv_context.hv_numa_map

Joe Perches (1):
  hv: Synthetic typo correction

Michael Kelley (1):
  Drivers: hv: vmbus: Implement Direct Mode for stimer0

Olaf Hering (1):
  tools: hv: include string.h in hv_fcopy_daemon

Vitaly Kuznetsov (4):
  hv_balloon: fix printk loglevel
  hv_balloon: simplify hv_online_page()/hv_page_online_one()
  hv_balloon: fix bugs in num_pages_onlined accounting
  hv_balloon: trace post_status

lantianyu1986@gmail.com (1):
  vmbus/ring_buffer: remove some redundant helper function.

 arch/x86/entry/entry_32.S          |   3 +
 arch/x86/entry/entry_64.S          |   2 +
 arch/x86/include/asm/hardirq.h     |   3 +
 arch/x86/include/asm/irq_vectors.h |   7 +-
 arch/x86/include/asm/mshyperv.h    |  13 ++++
 arch/x86/include/uapi/asm/hyperv.h |   3 +
 arch/x86/kernel/cpu/mshyperv.c     |  41 ++++++++++-
 arch/x86/kernel/irq.c              |   9 +++
 drivers/hv/Makefile                |   1 +
 drivers/hv/channel_mgmt.c          |   6 +-
 drivers/hv/hv.c                    |  65 +++++++++++++++--
 drivers/hv/hv_balloon.c            | 121 ++++++++++++++++++++++----------
 drivers/hv/hv_trace_balloon.h      |  48 +++++++++++++
 drivers/hv/hyperv_vmbus.h          |   4 +-
 drivers/hv/ring_buffer.c           |  49 ++-----------
 include/linux/hyperv.h             |   2 +-
 tools/hv/hv_fcopy_daemon.c         |   4 +-
 tools/hv/hv_kvp_daemon.c           | 138 +++++++++++++++++--------------------
 tools/hv/hv_vss_daemon.c           |   1 +
 19 files changed, 351 insertions(+), 169 deletions(-)
 create mode 100644 drivers/hv/hv_trace_balloon.h

-- 
2.15.1
