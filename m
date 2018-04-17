Return-Path: <moritz.fischer@ettus.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523936672; cv=none;
        d=google.com; s=arc-20160816;
        b=O9pat5j1mJhMgY/h4hqAbldic74VRYnfa5DpyOrYpv6ArjL16QH1vyJbpuJ3QX1MGk
         tkIP7Sg6UMwyzKLM/THAGlI15qbmjil7J+UmgvVODcQ39coXxkH47NoleK+P/2qZZwUb
         f3rPxOa/YCBT3/PWEiB0Othz8JphEHWox/MFgdIhFI7KVGIiB8+7nKrM+3r9SrcYDrZX
         jQ7zOa6TCs3qpFrjfgfBlY1ni5RN4Jjk15pCPqxkXV/y2Y3A+88rT/bn1N/3NYxyoV+F
         0adtIrfYBpHjGCXUMFU1UhcLtTaKX89HfKYan7SeNDL6wySfT4glKO//x+UGWwasyibm
         Legw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=K5r4Dlx/GvRDbperu/DgflxXBJ9igx/MBb94JpJj5FQ=;
        b=UUbXsWOhQQauAZgSwV0me9THtwduVpsiI6W4cbvU37QrgY3odc/kZYVISA/Ri1AZS+
         kXKczhzC10AoITmjF0NFIWj1zDKwesjIZGNojzuJM0RGFZHe1Kb/3uuzweD2sPwRF5CU
         WzdP7Ce7ZROLt/xOUtNyFyQmyH6VG+JBoMyBYwvTqVHq6q2xJ3iFz43a+FkH9s4fQXMk
         2cl6M8XRoJz9s5vtpdhV+NoeojAnIJ9YK49QF88TYoX7VsIrl1y43okT/K9KinnEHHFW
         XJTgFtsUJEkwNNLR67mkLG+/P8nvBjIb7HKEUXjcP+iqS+zspF59Cgb62VHTjuuyEsfr
         q6Ng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of moritz.fischer@ettus.com) smtp.mailfrom=moritz.fischer@ettus.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of moritz.fischer@ettus.com) smtp.mailfrom=moritz.fischer@ettus.com
X-Google-Smtp-Source: AIpwx4+qyU+vFONzpm27rpiApknEqlH7LZz00vhVUVzBwK9CEal6KI4E1OFppmFF52NoXbytdieKBg==
From: Moritz Fischer <mdf@kernel.org>
To: gregkh@linux-foundation.org
Cc: linux-fpga.vger@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	atull@kernel.org,
	robh+dt@kernel.org,
	Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 0/3] FPGA Manager Patches for 4.18
Date: Mon, 16 Apr 2018 20:43:34 -0700
Message-Id: <20180417034337.8855-1-mdf@kernel.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597963419619152195?=
X-GMAIL-MSGID: =?utf-8?q?1597963419619152195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

Please queue the following patches for v4.18.

Alan's Patch clarifies the locking in the fpga-region code.

Paolo's patches add a new driver with corresponding bindings for a
Lattice FPGA part.

Thanks,

Moritz

Alan Tull (1):
  fpga: fpga-region: comment on fpga_region_program_fpga locking

Paolo Pisati (2):
  dt: bindings: fpga: add lattice machxo2 slave spi binding description
  fpga: lattice machxo2: Add Lattice MachXO2 support

 .../bindings/fpga/lattice-machxo2-spi.txt     |  29 ++
 drivers/fpga/Kconfig                          |   7 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/fpga-region.c                    |   5 +
 drivers/fpga/machxo2-spi.c                    | 403 ++++++++++++++++++
 5 files changed, 445 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
 create mode 100644 drivers/fpga/machxo2-spi.c

-- 
2.17.0
