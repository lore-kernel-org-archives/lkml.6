Return-Path: <Rasmus.Villemoes@prevas.se>
X-Google-Smtp-Source: AG47ELurcHkINnyn2euvEdwZ+/mWLyApEqqRAfjO0s5M9YizycZDmiUyrKlNs9kKWfaTLgpCWP1j
ARC-Seal: i=1; a=rsa-sha256; t=1520428249; cv=none;
        d=google.com; s=arc-20160816;
        b=mrVkwsGsv/Rw+M/Ht2PzNx8LgpkO0ZAQ70ftLEGNHcPWlaLEAkRCfgMpHq7Ktxy8uv
         07y5qxJP8a9fmWfr/hpKUh7sTmTg9C8KlkAcVeoQ2vqYqSSUROB8aStm9iIVwNKy8MY3
         wIBWvWziBlbmZXKps3IMcLs0dfCH58NtDwim7iO7MKrJz0+GOp9MjipWvk+Q/u9Q7eUh
         hdiMxoBDGIAM98m62MZYypA8xfCXNn1s93xakpkXh+fDysdPwRUahtVwBi7IPAEelYnS
         2urHA9ZgjkbzXrdYsc/Z1j77hGVmpnVzIMMjbB1lWF0tnH6Pqfj2T1E9HHX4lwG23GCc
         d19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=kiw2RVTHaqUXctMI5vPFo6jwvTdeyskfkxCaiasIWRU=;
        b=zZyJV6OGj4vsiRhwPGFS0tRKGo45m7BcIggrk7+GFFE7MoHK6kLsj4lWJ4NEjl/9/p
         MRiRJEVAKC2Q6z9URhMy9uAaBk8ftxw88ZauOGj3uSju36texq+CUDzn7zU5uZ1cqu0/
         zLtPntslgzUCq/+gZg27wdsvIk6NjebZ7BMTnW8wOHi61mA40HHNkCdwShL63Bp9crcD
         jA6t2G4kQUYSMZb83KcFNqH4SXdQ0Y7pLkPlLFLCiUR+uUwQEvnTwIc1ZgdCXEme/12z
         9SCwcjJD1gykBG7hluj6qG0K31lRvFPBsUZSus0q9mF879FVafHlQq/eAvt4NqS5aiJR
         lZrg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@prevasonline.onmicrosoft.com header.s=selector1-prevas-se header.b=iAZ/pCg9;
       spf=neutral (google.com: 104.47.1.93 is neither permitted nor denied by best guess record for domain of rasmus.villemoes@prevas.se) smtp.mailfrom=Rasmus.Villemoes@prevas.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@prevasonline.onmicrosoft.com header.s=selector1-prevas-se header.b=iAZ/pCg9;
       spf=neutral (google.com: 104.47.1.93 is neither permitted nor denied by best guess record for domain of rasmus.villemoes@prevas.se) smtp.mailfrom=Rasmus.Villemoes@prevas.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se;
Subject: Re: [PATCH] staging: lustre: Remove VLA usage
To: Kees Cook <keescook@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, "Tobin C. Harding" <me@tobin.cc>,
 Tycho Andersen <tycho@tycho.ws>, Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>,
 Dmitry Eremin <dmitry.eremin@intel.com>, Gargi Sharma <gs051095@gmail.com>,
 lustre-devel@lists.lustre.org, devel@driverdev.osuosl.org,
 Kernel Hardening <kernel-hardening@lists.openwall.com>
References: <20180307054608.GA9300@beast>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <d5de0034-6f74-5b73-2df8-dbe5b366c2fc@prevas.dk>
Date: Wed, 7 Mar 2018 14:10:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307054608.GA9300@beast>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: HE1PR05CA0192.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::16) To AM5PR10MB0435.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:203:25::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09b1b293-37e6-43f4-edd2-08d5842cd700
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7026125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM5PR10MB0435;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR10MB0435;3:TBDV3jrDjiJXirVtt59yFaeaiSoTxVKOT1X9zZSc3SkG84p1gTF8TGQnAb8GEerUwn3T8sXRi3tCjPYoHlmG+cSrQUzKpZf/EFg0OwF2fkLUc/hwkno5xK0LaHq1RUOys8p/y8RHviW0DmeRzvn4evW4NtcU4I4xwfDWuaipia+VeWFHMOvtB1IZQY3OlKpeQM+E5H1bh3O2woS/Fke6uPuVaycwYuI/qc6R4sXl8oZZKkA/iuLLWraNWCrSme7l;25:71zEQscIWTKELB/86L54BSRWcnJpeABJfvg5ZOIt36jSOescVNa2tRt6iaqqNFCLCTwCvCffqj+XuPQAk0Bi+BWwE3pbEqQm5+IAhuYhTMukW/JsjBfEJHxjN2EgjT/fOv9QBs/3S+NaaHqByJN7HETwj63dUiQ8OBoic59vlEZ1WIpST0QUHRbtrCNewsYPAyAFG3Nek7fYEcqcbGMOg3C0Stf37b8bh44/nBV9Ux6ttMkjTTWZgQfZJvskfNim+8AUlE4yyREVsxzJDaLaI6UY+B13gp/sd6oDr5y9rsyFmx5yzLHggO4eIXmajwmk4tckilPDztqxTldbD1OuuQ==;31:T1j+ynLmITyPdbfKA7IDVbjtyXv0tRZJM1X56uwnKGLlhHS0xXhAcxppe7PxBhkAmrgI7KcGW+rAxtH0p9kxqfAKgEV8TEt5aaXbK0IJh1CZUHd/zp8jWNueoB7SVyC5+ST49bo4+szw52RtZx8hS0f4twPpOsTcI56K5TkR8Z2tVkvNMnJ8DDacxxMli66jW75vn9/2JwvDANMnRez9Vflz86Z9AVn9CpDt8iMDtpA=
X-MS-TrafficTypeDiagnostic: AM5PR10MB0435:
X-Microsoft-Antispam-PRVS: <AM5PR10MB04359EB7942AFCF45F5CD9598AD80@AM5PR10MB0435.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6041288)(2016111802025)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM5PR10MB0435;BCL:0;PCL:0;RULEID:;SRVR:AM5PR10MB0435;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR10MB0435;4:j7dCGQd/2aNOYfT9pIXm1PB2BRpD669Qztpmb6pOZglLWgE8BEbQgONuTTqgHP/KQE+DpGAti+K2I36GsTr6icXtfR4ZY5UMJAqDzn9W1rNJlzw5tu2hSyRURaA47vkSmQhU87zQisU0xO7sA0ta84MX/DmBzvymsysEYQsCstWyiCiSSnA3VgOt/Re4dXBPuHFcYomybdFJXyAW1UokzaL6+SQg23hRZsUb0MXL8CGEMdll6Sn7VW5ON3HeQgmd99m34D0TAmLzh8JjRW0atLJuJ/RrphUREIQEg0LiI13aV6oBefsufN9U5kqZAlDz
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(7966004)(39380400002)(366004)(346002)(376002)(396003)(39850400004)(199004)(189003)(377424004)(2906002)(74482002)(25786009)(6246003)(7736002)(106356001)(8936002)(305945005)(16576012)(2950100002)(58126008)(6666003)(53936002)(8676002)(54906003)(110136005)(4326008)(230700001)(39060400002)(81166006)(31686004)(47776003)(81156014)(6486002)(3846002)(7416002)(97736004)(316002)(65826007)(508600001)(72206003)(36756003)(6116002)(52146003)(52116002)(8976002)(23676004)(5660300001)(68736007)(229853002)(66066001)(65956001)(31696002)(65806001)(2486003)(42882007)(53546011)(50466002)(77096007)(26005)(59450400001)(386003)(64126003)(186003)(76176011)(105586002)(16526019)(13693001)(403724002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR10MB0435;H:[172.16.11.22];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjEwTUIwNDM1OzIzOk9PMU1zOTZDOXdKckZSNFIrOGg2ZGhpSWlC?=
 =?utf-8?B?ZjZkRWVLMWhzZmorYmtYODlta2traUswV2xtanE0VzdKelRYbXZReUxWZHNl?=
 =?utf-8?B?WjRIY3orL25XOExaaWlaUXZLaTV1Z2d6MFlZRzhkV3RibkRDbCtzM3RIdDNz?=
 =?utf-8?B?MG9ydGZHamtDNklLNjNSL1FkeWViNS8vdHcyQUxIWHp2eU54dXhlRittTFdN?=
 =?utf-8?B?WUlnWTFlYzV5Y2dKcjJZSmhPZzVzT1BWMVFqdWtDY1JZNS95NkdaYWFva2ZO?=
 =?utf-8?B?TUNxcnQ0b3FKeERRQ3dLcU5uUFJ2Uk5VQnFFdFkxYUY5VzVJdmZSTk5WVlJn?=
 =?utf-8?B?RHVUaVdWblZFM3NrdUg0aWJRd01iU1VmMGVLeXlRNkJJZGFreTVmWmgyaHN1?=
 =?utf-8?B?aEU2b2o4bU1GWnJDVmRqeHNObmpvZkhyRFNYNEdrU0s5RENHWlBYekNBdWVr?=
 =?utf-8?B?Nko1aTB4WTd5dnVKLzIyMm9BcksyMXZEeHUrOGJrM3pGTWU4SVNqZEE2WFpB?=
 =?utf-8?B?bzY3aUo3K0hENTcrczhvQzNpTWNBQkNXL2xHYkVqYWVCNDMyV213MG5RdGRB?=
 =?utf-8?B?OS9nRlhMdmdSS0kvNnc1UXBKQTVRbDU0R3l0amRsamhqWHpLSnovT0FHZVRT?=
 =?utf-8?B?WkFxYkt2Z09zZW12NGl6RnMwbVNva0p5SnBJd0xOMEJDOXQ1MklJV3UySmJC?=
 =?utf-8?B?dUZXaDk5cnBNWElIK3lXMVZhVzZjeThCQTJWbHBPaTg5YWthUHpoS1FvcTJh?=
 =?utf-8?B?NWxWQ0U0T3YxbENDUTVPVlVoeHArY2ZqQlk2OWVFMFpnWnR5dzVwaUNjVk84?=
 =?utf-8?B?WHFGclJvKzE4K1JGRndlV2dGSFVNZ2F4aDYxWnptTEdrWjJMcml3MnRucnEx?=
 =?utf-8?B?NTk5eHB2c0RHWmI0VFJPUjdjdXFvYlF6UnNibWE4ckY3Z0xGcUFHTDR5SVAw?=
 =?utf-8?B?ZWRYRmVEMnZyelU5aTYwdU9PajBuRFlEU0tacUx0cEJ6N2ZBWUZHLzBKMW5C?=
 =?utf-8?B?NVltNTVYZWxjL1VGaEpyTFMwVXhwakxqMHFKa21LN2dSdlUxTDh3NTJ6RFda?=
 =?utf-8?B?YW9wbEJhS05yOVJEUy9PZURJR2VVNFpOSkc2SnZDM2hpWGg0WXJSVStBV3U1?=
 =?utf-8?B?RWxPanpGOExaQVUzUEo2ZHYxRlRORjN2aUYwRkRQTFI4UGlnZHBNVG1YWVNK?=
 =?utf-8?B?M0d4VnZFZExjRGF4NjVVdk5lc1VLL0xiZkVUOGc4QSsxQ0RiODlucldOQzYr?=
 =?utf-8?B?WjRnYmppeERCcUIvNFJmMC83b2psZG9neUtlTlA4LzYrZ1RRNmw2RVcvaktI?=
 =?utf-8?B?Y1hDTVhubC9EVFZnVHhnUTZ3b01KMUFDK1QvNmpYeFdDeWIvWGViUkpDRTVU?=
 =?utf-8?B?M0hMYmZnTW1xS1FvVDNJUUhuaWtoajFHelBSUVZwR24xY0pMY0JCVVdaVnlh?=
 =?utf-8?B?ZVRNekgwUUhoT0RteXdxOGdtQzd0c2NSSXh4YXlxVEY4WE1aUGZGVFpma3hE?=
 =?utf-8?B?N2JKVkJCZGp2MmhFRkNHNFIySHlCRDdlUUt5K2FYeWJLcXpDditFeGUvTHcr?=
 =?utf-8?B?dzlBVE1vcklva3NkRjFTdGxGY3l0NWpGd0ZJckhzc0U3bnMweXJVb2FpdDdz?=
 =?utf-8?B?RkFaSyt6c292MzZuV05nellocDVMUC8yZFROUkdBUkUzY3A3d3c5OWRCa0NP?=
 =?utf-8?B?bHhtNkMzME1UUG1nd1lKUkRqcGtlckNoc05GaGJQc21Wd1RFS0hXMUdGczBC?=
 =?utf-8?B?aHd1aFBoZytwSVg2ZytEUTYzdmNDUVZuN3Q2Q0s0bXgyK2tNaFhZZ3lMNm43?=
 =?utf-8?B?dXJnWXpaUmVETGtaSm96Tlk0VlJ3Y3pQV1NyaUlidEN6UWhzbXdJZnNaVGhG?=
 =?utf-8?B?amxneWlPT25OMzVMSjVmUTFUWExNbk8wMlJGbjJFZk1SN3BKZWk2cUhrMmYz?=
 =?utf-8?B?TjJYWmRHbGdXMHM1SzRGTjY3MGlSQnFpVStEZU1kbzBiYUZjV3kzbWJvd3l6?=
 =?utf-8?B?RkRUb0xsZXN2bVNWa3JjVnVLaFh1bmNwRm5acnZZd2t0Y0FaRVFVU0JZcHdi?=
 =?utf-8?B?V2tDczNSOTh5K3BXeXRSb1lGakJQWkp2ZnJJN1hlREtabFFTNXAzN3gwbGJL?=
 =?utf-8?Q?o2ubxzAqYSyBqQkeAZDI1v8=3D?=
X-Microsoft-Antispam-Message-Info: 0LevWqdcc9KTWVo0ZsdVLADbvB1YvDijqtAA+cK+kJ2SsGeFL6/jLG8W4KFhFm2VXFO+9A6jR1+qaGYa0cYOLoQlRyCAGb5Y28FWnL1A8SEu1FUCAPmx6kISmsDmzx3S+5hv6s1ioQzrpt7MmH397wcV4D8erDdhkmaY61UGA7sZ+f/rBNNnmAiUhxEJ2kZn
X-Microsoft-Exchange-Diagnostics: 1;AM5PR10MB0435;6:RoBs3r00CXYkHNwXWyx0g6W+nyuadRB2SuGqIDvCi4NuMGqbfmO3op2UVSHjk5FiQnrxBqKbZ8hZ07/vvqqajbrLWqOjKutChbULEx2ibW8og441Xu4OxI0nPamP7kn00qyGltRjQug60snXl6IWbvR0WmdtKMnyVm0q/f62BycCkDlrI8vJIXtyFk9mk5IBfSbMIyzfmEwJ3Rr2lYYQ6k+HE5lx0MD8JBU+k+eDTnU+FTQMew4ZRp51rjsSlp7zn875U/ResLm4KP8pgojkOV+xVtIcKLLBmBZwWzHpF/CzF9Dd2sih4WJ5iGVUIuMFDw58HRfoQwmFAcDNsYL9C6BNjXHgLBspVlfuGDtQMKs=;5:hJavV8EmCPQSgMUEp5cUIIgrXg4oKxNJ/1htdOsOT7NzB44OdYXTaJwC1JKcq1nXlaBkiLw7aJ6nY1nlBJmDqdj50jLuWi5NfsgdqvNaNDmCgOXWIxE55PHUocTpfzcQNvBASexJKd5Ciuu1xjdho4J/HyMyodXyoBI9JTM1QpQ=;24:IkZBMfoKoFcI/zkLzDepMxwyVsPqneYiZFc6OEeySyMGdPQmRP1Sxso26X45ZERoKslmmrluoAe0PpFuZygDoJujgzjIFx451V4eNq7DWRs=;7:GfDvoAUmd0xEzJbOxsCJZBE7iSVtC8qb0giKfJqgJHU4yNBY+I75Yv5dzt/WyO2e6rydH+O128IKbWvYzW7yxawuxyZCAINQG1w84IFui3jEcCc+cbewQZixDXr+fHfdF/qv/wJjnhWOXzlX4VXsP6d53WU50YOtz4u4wzs7eCu3ZdEtDxgIYRcLjJ9gfqWD0ErvQc5n0OkTQDsPA+YtXTrHfl1qGn6HFeW/8B89v3/5BNv/6NTLHh8DIccX9Ay0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 13:10:45.1976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b1b293-37e6-43f4-edd2-08d5842cd700
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR10MB0435
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594256599062880718?=
X-GMAIL-MSGID: =?utf-8?q?1594284571646004607?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-07 06:46, Kees Cook wrote:
> The kernel would like to remove all VLA usage. This switches to a
> simple kasprintf() instead.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/staging/lustre/lustre/llite/xattr.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
> index 532384c91447..aab4eab64289 100644
> --- a/drivers/staging/lustre/lustre/llite/xattr.c
> +++ b/drivers/staging/lustre/lustre/llite/xattr.c
> @@ -87,7 +87,7 @@ ll_xattr_set_common(const struct xattr_handler *handler,
>  		    const char *name, const void *value, size_t size,
>  		    int flags)
>  {
> -	char fullname[strlen(handler->prefix) + strlen(name) + 1];
> +	char *fullname;
>  	struct ll_sb_info *sbi = ll_i2sbi(inode);
>  	struct ptlrpc_request *req = NULL;
>  	const char *pv = value;
> @@ -141,10 +141,13 @@ ll_xattr_set_common(const struct xattr_handler *handler,
>  			return -EPERM;
>  	}
>  
> -	sprintf(fullname, "%s%s\n", handler->prefix, name);

It's probably worth pointing out that this actually fixes an
unconditional buffer overflow: fullname only has room for the two
strings and the '\n', but vsnprintf() is told that the buffer has
infinite size (well, INT_MAX), so there should be plenty of room to
append the '\0' after the '\n'.

> +	fullname = kasprintf(GFP_KERNEL, "%s%s\n", handler->prefix, name);
> +	if (!fullname)
> +		return -ENOMEM;
>  	rc = md_setxattr(sbi->ll_md_exp, ll_inode2fid(inode),
>  			 valid, fullname, pv, size, 0, flags,
>  			 ll_i2suppgid(inode), &req);
> +	kfree(fullname);
>  	if (rc) {
>  		if (rc == -EOPNOTSUPP && handler->flags == XATTR_USER_T) {
>  			LCONSOLE_INFO("Disabling user_xattr feature because it is not supported on the server\n");
> @@ -364,7 +367,7 @@ static int ll_xattr_get_common(const struct xattr_handler *handler,
>  			       struct dentry *dentry, struct inode *inode,
>  			       const char *name, void *buffer, size_t size)
>  {
> -	char fullname[strlen(handler->prefix) + strlen(name) + 1];
> +	char *fullname;
>  	struct ll_sb_info *sbi = ll_i2sbi(inode);
>  #ifdef CONFIG_FS_POSIX_ACL
>  	struct ll_inode_info *lli = ll_i2info(inode);
> @@ -411,9 +414,13 @@ static int ll_xattr_get_common(const struct xattr_handler *handler,
>  	if (handler->flags == XATTR_ACL_DEFAULT_T && !S_ISDIR(inode->i_mode))
>  		return -ENODATA;
>  #endif
> -	sprintf(fullname, "%s%s\n", handler->prefix, name);

Same here.

I'm a little surprised this hasn't been caugt by static analysis, I
thought gcc/coverity/smatch/whatnot had gotten pretty good at computing
the size of the output generated by a given format string with "known"
arguments and comparing to the size of the output buffer. Though of
course it does require the tool to be able to do symbolic manipulations,
in this case realizing that

outsize == strlen(x)+strlen(y)+1+1 > bufsize == strlen(x)+strlen(y)+1

Rasmus
