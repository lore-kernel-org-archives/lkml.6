Return-Path: <cgxu519@gmx.com>
X-Google-Smtp-Source: AIpwx48can4I8GDJq3x6jQ9Hs3LLPhqtUZJta0QSkv5GbYmP3YIBICk4Vc0Vj09AUqJhqY6czcYQ
ARC-Seal: i=1; a=rsa-sha256; t=1524101037; cv=none;
        d=google.com; s=arc-20160816;
        b=zDkXklSEdqQ+ceRfeGvc3lrVR5JIOwWWH4ZPsjRo883lP0cgrlofX7pwAI6l3upDaZ
         E+oQS8dPrZd+dJhMTLc8Fw9hx2bn914NZmVc0Y5c0dppyl+RDyzT1uR5POx1brOGbdCh
         lusVGAFJEqRsFR875J0d9bFbHxwxXFDDTB2W/wE42AkhEUTn7uepW1sWfx9oENEAvRA2
         1YpUiWBAcO/WyOPN9j9a+df5jwCh9tX2G5+LZn0kzbBpmM5uKC/yz5oFJDnvF1kIs1gF
         TcEt+oGHq5qecemVOC7fGA1ovFth/v56+0QoRCA7XAzXwZB5dBokXK74ID6aSImneg+X
         xtcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:arc-authentication-results;
        bh=dOYwvM9Zz/BQiy4/rR6tgXiSrw16b0q0Kh44R2MR9ZI=;
        b=U7bd3EJSlCPuM5aNOgZi2oi+1mhrmum3bv4znoe0UnPZ+fKMGZpuG2Z9YCaLzqD8wg
         h1HP7GKKY15+ebc0BkeZj10wm6P2IFaS2l3huJysTRcOy8Hn021/j/oTQCjjVcY2bCWr
         KefEqiCNIedlfZJuwdeNmorC5MPMrFcOC0qpYFliY56bGG/vuX45CKWYuiTmLbpuy8rc
         ygH9Md8DTqr5gJDGZWCwRjDeKpFyyhCb7PYH/moTgsQ6C2puTYz7vM6oLtCaMcC0lvN2
         A4lR6E+UChsl+tGmUDOqj7H37zg9VXVl+2dTEtlz+oAKneMBt0x/XoEi0SquetyUaild
         590A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of cgxu519@gmx.com designates 212.227.17.21 as permitted sender) smtp.mailfrom=cgxu519@gmx.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of cgxu519@gmx.com designates 212.227.17.21 as permitted sender) smtp.mailfrom=cgxu519@gmx.com
Content-Type: text/plain;
	charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH 1/2] hfs: fix potential refcnt problem of nls module
From: "cgxu519@gmx.com" <cgxu519@gmx.com>
In-Reply-To: <20180418124251.d66a36cb23673f0d8b152910@linux-foundation.org>
Date: Thu, 19 Apr 2018 09:18:53 +0800
Cc: "cgxu519@gmx.com" <cgxu519@gmx.com>,
 linux-fsdevel@vger.kernel.org,
 dhowells@redhat.com,
 kstewart@linuxfoundation.org,
 gregkh@linuxfoundation.org,
 tglx@linutronix.de,
 pombredanne@nexb.com,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <060F1E17-ECD0-41F5-B635-2A0E16967433@gmx.com>
References: <1523948733-8537-1-git-send-email-cgxu519@gmx.com>
 <20180418124251.d66a36cb23673f0d8b152910@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3445.6.18)
X-Provags-ID: V03:K1:94Ni1M2+6nulXzCtIP/kFm7fC8a/Q3vVOfeMvKvg3ZycW2RDzYp
 X7q+lZCAlIOvvhTDXcrSaEza1HirJ/EMghHvYUsj2EMxyZBhUc4Jg3HThKtEdth5220OGDP
 hrIRZoqeyiknRlEBRAJiEaLN4wFEc2VKOziauj9Rius7lPlhXUZ+UE1XPd2avH8TSuPjCWl
 K2IV7Ispc8IB07P1Wpfeg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6hSb458qU5E=:NiadXJpqlJwBaomoWs2o34
 mTBJxh2TjTtX2oOHum7O8Pg+LMiDNLHPaFTmmtL7JOEJkbQ3PlIRYPebGnT1DBCeCzCwKykEl
 9lN9fz6jjQdczOR18SfszyAgmvDVn5FNPcjeSGpnMPvt74AD20B1JLQAcipndo1b9ikVetgPP
 reiuQO0x6fPK3ZFEr+HtxWFMdnmpsh+xa80xKhyYifplkli4RGQhx4Or0Pm2IgajtppUjqsAW
 stLguxvyZdrEHhSDYJDRKecqSiEGkYwETQ97Y/Z/EemAC15XeaFbBoiyws6lUI32dSbusVPzh
 UWuDKy5zhez9EzMS80dEEaA5CMrCP5DhDSmvghgVxOWj5gTtnu/bhHl3pv4xisplcH03ci4t8
 V68oRRf8ip3O5EaIXbSSR/5GUEGbmS2MptPYO7XzPZk+b1VZuFHt8Zbou20E18PVhZ6hi8p/3
 4eC8FtZl5Fi7ZNcT2do1XRei0R2BcLLw/HilpSfmhC+tgm8rziPIRnX1yyzbmMuPVFqUqB5SS
 9gbfP+NwhYqTPEaT86vM1uKF7s21HPiHEVTYBa7Gq4qetpXmqRa7S9BcPet0kIBxIjw2pVnTR
 PHfuNQ1va49fZ/I9ApBzwZJZhKdfk5A14SaIfJmcjtZKpni7rPH0zgfJ745II6h4+93WqakWr
 /Z3cI2XX5krPHwe7UUlg6ViZi3k+wQvgJVxMgCdJIjkQNlWWLGnVkuO4C69LbReUar4dcMGn8
 8DgkabEUw8nCAP7TKlPeju+s9EqKnwPM+Rx5AoN4z/R2J0U0HthiAMfKrITvKYzKaWlJtqLPZ
 hAmDgtdBrebBmDjZNHjUU6JIRosX7+4BjNdbeGZuaKRmIecBC8=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597976097754652065?=
X-GMAIL-MSGID: =?utf-8?q?1598135769065560339?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

=D4=DA 2018=C4=EA4=D4=C219=C8=D5=A3=AC=C9=CF=CE=E73:42=A3=ACAndrew =
Morton <akpm@linux-foundation.org> =D0=B4=B5=C0=A3=BA
>=20
> On Tue, 17 Apr 2018 15:05:32 +0800 Chengguang Xu <cgxu519@gmx.com> =
wrote:
>=20
>> When specifying iocharset/codepage multiple times in a mount,
>> current option parsing will cause inaccurate refcount of nls
>> module. Hence, call unload_nls for previous one in this case.
>>=20
>> ...
>>=20
>> --- a/fs/hfs/super.c
>> +++ b/fs/hfs/super.c
>> @@ -329,8 +329,10 @@ static int parse_options(char *options, struct =
hfs_sb_info *hsb)
>> 				return 0;
>> 			}
>> 			p =3D match_strdup(&args[0]);
>> -			if (p)
>> +			if (p) {
>> +				unload_nls(hsb->nls_disk);
>> 				hsb->nls_disk =3D load_nls(p);
>> +			}
>> 			if (!hsb->nls_disk) {
>> 				pr_err("unable to load codepage =
\"%s\"\n", p);
>> 				kfree(p);
>> @@ -344,8 +346,10 @@ static int parse_options(char *options, struct =
hfs_sb_info *hsb)
>> 				return 0;
>> 			}
>> 			p =3D match_strdup(&args[0]);
>> -			if (p)
>> +			if (p) {
>> +				unload_nls(hsb->nls_io);
>> 				hsb->nls_io =3D load_nls(p);
>> +			}
>> 			if (!hsb->nls_io) {
>> 				pr_err("unable to load iocharset =
\"%s\"\n", p);
>> 				kfree(p);
>=20
> Confused.
>=20
> 			break;
> : 		case opt_codepage:
> : 			if (hsb->nls_disk) {
> : 				pr_err("unable to change codepage\n");
> : 				return 0;
> : 			}
>=20
> Here, hsb->nls_disk is known to be zero.
>=20
> : 			p =3D match_strdup(&args[0]);
> : 			if (p) {
> : 				unload_nls(hsb->nls_disk);
>=20
> So this will always do unload_nls(0).
>=20
> : 				hsb->nls_disk =3D load_nls(p);
> : 			}
>=20
> And the same applies to your opt_iocharset change.

You are right. Sorry I just misread this part, please just drop the =
patch.

Thanks.
