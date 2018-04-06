Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+LKl3w+unosiAmUj1WypVoegpLBVzyVvcd6EFkqtaCEPOxW+4zOknj93mNh4tOhbjMNIIc
ARC-Seal: i=1; a=rsa-sha256; t=1523021602; cv=none;
        d=google.com; s=arc-20160816;
        b=OZbHFzdgD6Uwobqz6LW1uzoYlLU2MZsgfEWR64wtMKvyM0RC6IF7pmksr+6GvCmfZ8
         0ontcCy8BF+3E8AAfixBplMdLYMvCz4IglZ3u6wNhzlrKcDPn0tItMjQ5cfRTbZ0FtZx
         ofpEnuGLLDRf+5oZ84hnBgHP6L5cITpUK5rsStZBQ/fxhvk96uUZQvMwMYl6sdiW3EUW
         6NFo92IZfC1HG1yYCxznwmQLZIk2uFaCqspZ0+lCAKfsPogAQWAOEqdhvs0D++nvigWN
         bs9U4Jglt1ZOuCB/7ZHxQSbHNJ07KJb13ZWMXhAj7pQYdp3+NRjhBj7xenDJ95KTGReg
         ODQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FrLX3Y+7xQTAnT2XyVjcUcIaAg3ynCShZwnhBRmPqwE=;
        b=RA4fdZcCx0u4F1v3/091/OuRHgTYUPj8mdw42i/pu0dD6VD8fcCfE4N813xnzLSoQv
         +UHdFQSMlx/g4+2zXBvq6G1gs3f2VD/0kJJDs8AKb+QIqu1nFPzeYgBx8WMOsRdTwb38
         xZA7HvrpRcB8Hn9B/O9Ju8U8tVe0hbWCyMS67SXy+lvsYTvY96zbHcS1e39+mM5PcVqP
         nSF4RqD4otZAfyLjZTGViQTqySVvlM5j4HcPAJw23CfPOFW4rsywxL1k0Z17Y3QhmnZl
         Dp+mrGW+kj6wmTSCjqxe1sCOHBpQyuPWM1n+ySHy03xjRnu/j5knj2JFlJkcm3uSL3jV
         c99Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Krzysztof Opasiak <k.opasiak@samsung.com>,
	Peter Chen <peter.chen@nxp.com>,
	Stefan Agner <stefan@agner.ch>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 023/102] usb: gadget: remove redundant self assignment
Date: Fri,  6 Apr 2018 15:23:04 +0200
Message-Id: <20180406084334.866211955@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003900377763837?=
X-GMAIL-MSGID: =?utf-8?q?1597003900377763837?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Agner <stefan@agner.ch>

commit 8a8b161df5ce06ef5a315899f83978e765be09e8 upstream.

The assignment ret = ret is redundant and can be removed.

Reviewed-by: Krzysztof Opasiak <k.opasiak@samsung.com>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/core.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -139,10 +139,8 @@ int usb_ep_disable(struct usb_ep *ep)
 		goto out;
 
 	ret = ep->ops->disable(ep);
-	if (ret) {
-		ret = ret;
+	if (ret)
 		goto out;
-	}
 
 	ep->enabled = false;
 
