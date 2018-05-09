Return-Path: <songjinshi@xiaomi.com>
X-Google-Smtp-Source: AB8JxZp1C1lDKoBaB7ySqs11Iu7c20Ohthzt8NRLXVAV1gOcY/XWQ8roobbpHUX1egR/Etsb7B+f
ARC-Seal: i=1; a=rsa-sha256; t=1525851114; cv=none;
        d=google.com; s=arc-20160816;
        b=LeE5BjsS2Kh4Rbg5PDFMBR+BpHtlaSuFUcqijYGWDrSnonfBsSIqUdy9BR4dI4RXW8
         a49TvmV7XPHAkiW/eTkoNHxjoHOkcaA20VH4ORXCwvORfkWT/jPugVfAixYAAzqkp7NE
         3GaJ09sdlluPF9usoXGmbSh8jYrolIF/u/xq5L8rADUGj012sZyxTMA8zomBveQ+ToyA
         hUFotOMhuYIVnoGTB8KDpCvEBsmtp1r9RMYGifYH/JZ/qJi+qDdMFnAfub6Duv5wkcNG
         uH2ukPKOm37jNJvDpxMmYpKErd9cCw7OcwKxwPy1S0ts+ElIER+fseV0SK/E+f7xr1DP
         JEEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:arc-authentication-results;
        bh=S6basPVgK8eU4Yw3aIzOoZ3vhe0xeDRruOWjZaO9qUw=;
        b=OaDCUN+yeVnF4F1qHZyODhFDq0q2bV8pTRnI1WpmgWJlH26kOQWWm5h/vMkqckx2OR
         1hBJSOZ7QF5rjmjLuBTGsxAB93rpd8hIUXZFShINsd93HYZ6FXdvOeiRFOr8xOS0ys+I
         i+q6D9kyxL4TZBrlr0fNPk2dodlY4W0Z73LbdEyl7eetre3DvCsPlt/KZ7E56CaFLzmj
         F4ZYvyjjsXre1gKZB5Q78fWZ0tbZk2ymrPCAf2AHCrG9tZElTrQtqFvwruSY8KrkugZL
         2LCNRWWdAqgymRceCwvTdGoewhzrroR6cZ32A55FAmEkrUYPKMh61l0WS6v+YOxtjXWC
         CtBw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of songjinshi@xiaomi.com designates 207.226.244.123 as permitted sender) smtp.mailfrom=songjinshi@xiaomi.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=xiaomi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of songjinshi@xiaomi.com designates 207.226.244.123 as permitted sender) smtp.mailfrom=songjinshi@xiaomi.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=xiaomi.com
From: =?gb2312?B?y8698Mqx?= <songjinshi@xiaomi.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"maco@android.com" <maco@android.com>, "tkjos@google.com" <tkjos@google.com>,
	"arve@android.com" <arve@android.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ANDROID: binder: correct the cmd print for
 BINDER_WORK_RETURN_ERROR
Thread-Topic: [PATCH] ANDROID: binder: correct the cmd print for
 BINDER_WORK_RETURN_ERROR
Thread-Index: AQHT52b+yfI34teHBEqLYMBM+7MiaA==
Date: Wed, 9 May 2018 07:31:29 +0000
Message-ID: <1525851089096.52313@xiaomi.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.237.10.121]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599970857323840855?=
X-GMAIL-MSGID: =?utf-8?q?1599970857323840855?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SW4gY2FzZSBvZiB0aGUgQklOREVSX1dPUktfUkVUVVJOX0VSUk9SIHRoZSBjbWQgaXMgbm8gYXNz
aWdubWVudCwKc28gaXQncyB2YWx1ZSB3aWxsIGJlIG9sZCB2YWx1ZSBvciBkaXJ0eSB2YWx1ZSwg
YmVmb3JlIG1vZGlmeWluZwplLT5jbWQsIGFzc2lnbiB0aGUgdmFsdWUgb2YgdGhlIGUtPmNtZCB0
byBjbWQgdG8gZW5zdXJlIHRoZSBjb3JyZWN0CnByaW50IG9mIGJpbmRlcl9zdGF0X2JyLgoKU2ln
bmVkLW9mZi1ieTogc29uZ2ppbnNoaSA8c29uZ2ppbnNoaUB4aWFvbWkuY29tPgotLS0KCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2FuZHJvaWQvYmluZGVyLmMgYi9kcml2ZXJzL2FuZHJvaWQvYmluZGVy
LmMKaW5kZXggNGZmYzg0ZC4uYWNkN2Q0NGEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYW5kcm9pZC9i
aW5kZXIuYworKysgYi9kcml2ZXJzL2FuZHJvaWQvYmluZGVyLmMKQEAgLTQwODYsNiArNDA4Niw3
IEBACiAJCQlzdHJ1Y3QgYmluZGVyX2Vycm9yICplID0gY29udGFpbmVyX29mKAogCQkJCQl3LCBz
dHJ1Y3QgYmluZGVyX2Vycm9yLCB3b3JrKTsKIAorCQkJY21kID0gZS0+Y21kOwogCQkJV0FSTl9P
TihlLT5jbWQgPT0gQlJfT0spOwogCQkJYmluZGVyX2lubmVyX3Byb2NfdW5sb2NrKHByb2MpOwog
CQkJaWYgKHB1dF91c2VyKGUtPmNtZCwgKHVpbnQzMl90IF9fdXNlciAqKXB0cikp
