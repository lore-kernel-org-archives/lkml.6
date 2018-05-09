Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AB8JxZqh1GqdfR0TBWmw7EH7/kZxHnNaryYVnGYOnDz6iTq2yz1JHAgGbd5WTEGjqcK2GuOX2WUU
ARC-Seal: i=1; a=rsa-sha256; t=1525844157; cv=none;
        d=google.com; s=arc-20160816;
        b=rIk5so9Mro5Boq5JAOuff1wg6egOKcO6qzl/RWvLgPgiAYWN3kVe6zg+Q0j1IL2M7O
         leX+zbQpEv6fA5L177Ei75Qxs76o7Hml8ph+rGzA38iwYNlvbfdImZNzRakS34AdNbG0
         hXSFYgJPR4bBiE4Ruqdtz6ac0WHjDEnj3Ju9BGF4xJX+rbNcbBhbToS0FCFVA3RjHTw2
         I6ZpJgig/vM268EsWaeR1tiysEIK6+5/YePuULPT5YHKrU5RV9ykyoD7+wg7ECtgb8al
         pE+AOAosjhG14GIzmqRndY4GIel5s3TT6I/ORF3zg8evTzBEh9DyhvTTJgGA+ZsQ7BcI
         Y87w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:message-id:references
         :in-reply-to:date:subject:cc:to:from:arc-authentication-results;
        bh=QBWk05edE5mejVmSDUGvY2zYn3auSKeG01rIduiuSRs=;
        b=j/5UZBuvjiuQ9sLAonvWeiw9t55XEreAl+MO8xrEJgJRzI3pCPGBWSfuj4SWI+Fk0o
         FHueb2WCGqhKJmzd/XJnN3JppscFPmeAzfDLZuAd5aZGwTMJBe9BuRB3x+rvvxVllihn
         fAVqc+mm0O5MFXg9WoXXZv+NEoYhDmiNgKpuuHqf4YqgquS4ma0PLEfacazoMsGrROnM
         tcpe1vw7D/xeO2t1JmAj0YfSSG5jYPb5ia5shapioxYIIY+l7sXjOFV7GCV2037DIOmj
         otwbHt0uXqYLdUcnOC1vM8qd3uuUqa2JEmzDAFOeGEty5ZqkXuGLgBQ8IFXuP1bCEONF
         qgTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH v4 7/7] ocxl: Document new OCXL IOCTLs
Date: Wed,  9 May 2018 15:35:06 +1000
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180509053506.9754-1-alastair@au1.ibm.com>
References: <20180509004212.4506-1-alastair@au1.ibm.com>
 <20180509053506.9754-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050905-0012-0000-0000-000005D43E1B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050905-0013-0000-0000-00001951527A
Message-Id: <20180509053506.9754-8-alastair@au1.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805090056
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957551491860164?=
X-GMAIL-MSGID: =?utf-8?q?1599963562994329182?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 Documentation/accelerators/ocxl.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/accelerators/ocxl.rst b/Documentation/accelerators/ocxl.rst
index ddcc58d01cfb..14cefc020e2d 100644
--- a/Documentation/accelerators/ocxl.rst
+++ b/Documentation/accelerators/ocxl.rst
@@ -157,6 +157,17 @@ OCXL_IOCTL_GET_METADATA:
   Obtains configuration information from the card, such at the size of
   MMIO areas, the AFU version, and the PASID for the current context.
 
+OCXL_IOCTL_ENABLE_P9_WAIT:
+
+  Allows the AFU to wake a userspace thread executing 'wait'. Returns
+  information to userspace to allow it to configure the AFU. Note that
+  this is only available on POWER9.
+
+OCXL_IOCTL_GET_FEATURES:
+
+  Reports on which CPU features that affect OpenCAPI are usable from
+  userspace.
+
 
 mmap
 ----
-- 
2.14.3
