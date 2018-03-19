Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuwjkTKgIGKH5VvhZMlvfsupiln2w5u5QQ7nnMWUKTDSI4ZYCgIjFUbS+7mTHLj2uKtCGzv
ARC-Seal: i=1; a=rsa-sha256; t=1521483597; cv=none;
        d=google.com; s=arc-20160816;
        b=RrBQHfbQT3kHF5OO+2Sj8N2DbeRnqCSNQmvXxYGoLGnUPZQapGA6b+X+nILG+Y6Vg7
         nMpCryDMehIeqKScMwg5Cnc5NU2uWvcjy/c1YD5xoYGzjuRCfYlXO+unMNOTgpSP3j4D
         2U+gZaqGT29WZItsw+4rlLTjd4kRDtB8MR2oH+TT2feS3IO9hDF+dRM7U663B/11kLtK
         yDH8YEJnY/Z4A7B9oD0JyRz4jI1saavRGxvcLw9MmnFNhSlmIGqVcgrXLfqs/aN2+R9L
         BvJ/Y1lNTIsDnQvv61tCcUtTIX0J6YvQYzQaeUfEdlEYjgZRTUOQKsnKFJzwj4gN+Wgy
         nahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nS8rgg+QN91CVYX5EmJyVEJpVE4AL0u9NZNDo948xTw=;
        b=1CMoPleu+NXFnQLrdCxppiLwQvaXzy1j6AAqjHEbgGdJy07eEdZ/jVNyyeMaysxEyL
         P2uJZy/KeLaduqAvJIBljpFMIdDylsCogqkU/m5b56tHTMBJqrwllvuYGDAqrkJvggAK
         B15tkn8KxlosN2N4wjO1eKXjQD8U5fJugOwOqMkE9pi3bqbtFjrKc02mJ5zftHJe01tw
         0HUDFNOaFSZVoRUX+I0UCKzWPQ8I5G8OuOyFMlxdQ/kK4B75jfChWjNsJxKoYOvFKF2M
         L9e1T2FKeqiYnJF/MWXN54CEAuPrT9nevwuTXhv+K8lZiuKW1oeHQuGLhNXbVfQEq8JR
         RQfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 047/241] s390/topology: fix typo in early topology code
Date: Mon, 19 Mar 2018 19:05:12 +0100
Message-Id: <20180319180753.137554986@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391185042175829?=
X-GMAIL-MSGID: =?utf-8?q?1595391185042175829?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <heiko.carstens@de.ibm.com>


[ Upstream commit 4fd4dd8bffb112d1e6549e0ff09e9fa3c8cc2b96 ]

Use MACHINE_FLAG_TOPOLOGY instead of MACHINE_HAS_TOPOLOGY when
clearing the bit that indicates if the machine provides topology
information (and if it should be used). Currently works anyway.

Fixes: 68cc795d1933 ("s390/topology: make "topology=off" parameter work")
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/early.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -372,7 +372,7 @@ static int __init topology_setup(char *s
 
 	rc = kstrtobool(str, &enabled);
 	if (!rc && !enabled)
-		S390_lowcore.machine_flags &= ~MACHINE_HAS_TOPOLOGY;
+		S390_lowcore.machine_flags &= ~MACHINE_FLAG_TOPOLOGY;
 	return rc;
 }
 early_param("topology", topology_setup);
