Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AH8x224RsCCzXv3iUoYIiZKzWzgGqCQvZHFYAaXmhBenKerDWFwjVS7E3Hjipvt+J68kc7SUpfDZ
ARC-Seal: i=1; a=rsa-sha256; t=1518552791; cv=none;
        d=google.com; s=arc-20160816;
        b=aEPMSLNMgs8vvnlZALnZONSUmh5Nqo1RCy85JIlmAnPPBlVVrI+IAgYxyRWAYJpmp9
         +I5qLiAtT6N9Bpxu+Z0iUx+RAy2zlLlSHx1RwguYihxlEVnw0v/p094hkURXcsgRIIxt
         O0TUZtMOpfd8n1TeXxuLyXinYN8oGe3LpI04RJGzOF2bnCON5y4ZgaTX50DFUMnOAcrO
         nwvjlXHeAZ7IMtzbp9tMlivc6ZD3mHebpzG3JReis5trAnOxJBkv4TmNJIvGLB4f2ZVD
         uaJn9EEK7XAEN7rYznVJtiX0E6+fJi4wCPbdSOm5C6+sqbzZqKdZCsQdIFVbxcjE+5nG
         8+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=CeHLlrz5jUKowXc+cBazRtPPkrhxSQvN8Ca4aaXk2Jw=;
        b=dwbFjhiGkADXpFkfTFKk5RCVkYLwde11Ldw1DXi18WjQ3GQNAMK8AxJKYxmr+VSTh9
         5DNZxnIkzmuLfFeKB1lvB1D3WcZYLy8yi+I98kIOWrBouE1a7JT+oRewFbZcG+myRArQ
         RIybh8SE3sbVTE67FW4Kq5kThmBnLm0qrDWA1PzKJXOnctqLusbdCIJE6CxNgk86tRD3
         B2NSIKKobRDuI3UlUOB3aRi3W2hA8WlO5J6kvloDy+UJg9ST0SWwZAlMZ9Z1Xh9NQdoG
         i4fsjtvUTWRZkOdIbwT9pbMaltSDwDLy1weJey3vR1TmAU0/gx43Jeyz4uQsPnstWopJ
         r8ag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
From: Vadim Pasternak <vadimp@mellanox.com>
To: dvhart@infradead.org, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH v1 0/4] platform/x86: mlx-platform: Add bus differed and auto detection functionalities
Date: Tue, 13 Feb 2018 22:09:32 +0000
Message-Id: <1518559776-188942-1-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592318011865134700?=
X-GMAIL-MSGID: =?utf-8?q?1592318011865134700?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset:
- Adds define for the channels number for mux device.
- Adds differed bus functionality.
- Changes input for device create routine in mlxreg-hotplug driver.
- Adds physical bus number auto detection.

Vadim Pasternak (4):
  platform/x86: mlx-platform: Use define for the channel numbers
  platform/x86: mlx-platform: Add differed bus functionality
  platform/mellanox: mlxreg-hotplug: Change input for device create
    routine
  platform/x86: mlx-platform: Add physical bus number auto detection

 drivers/platform/mellanox/mlxreg-hotplug.c | 31 +++++++++-----
 drivers/platform/x86/mlx-platform.c        | 68 ++++++++++++++++++++++++++++--
 include/linux/platform_data/mlxreg.h       |  4 ++
 3 files changed, 90 insertions(+), 13 deletions(-)

-- 
2.1.4
