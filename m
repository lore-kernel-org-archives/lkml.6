Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeCLS40 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 14:56:26 -0400
Received: from mail-co1nam03on0081.outbound.protection.outlook.com ([104.47.40.81]:59672
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751284AbeCLS4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 14:56:23 -0400
Date: Mon, 12 Mar 2018 11:52:59 -0700
From: Sinclair Yeh <syeh@vmware.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: linux-graphics-maintainer@vmware.com, airlied@linux.ie,
        thellstrom@vmware.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vmwgfx: Use kasprintf
Message-ID: <20180312185258.GC32341@vmware.com>
References: <1520445802-11894-1-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520445802-11894-1-git-send-email-himanshujha199640@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [66.170.99.1]
X-ClientProxiedBy: SN4PR0501CA0105.namprd05.prod.outlook.com
 (2603:10b6:803:42::22) To DM5PR05MB3289.namprd05.prod.outlook.com
 (2603:10b6:4:3e::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f7079e4-3405-4367-4047-08d5884af22a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR05MB3289;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR05MB3289;3:fuf2i0TPuh3hBNE6cHci1CS+kiGcOfYFyQUNlGOyHAnyLB4JMqHG3vfny3W/WlXp2jyI64AksggLFy37iSmEYiSHkN4Yfkiclt6rceeldaaEGoFBTOngMUbydCwfdEzrx9E7vgaZxXChd3MNx1asfc6Y0ImJuC+puEE7SNnCr8UFWAhLyGASDZBFaEqB4A+KNupfkvhNgvlXid8BvhGzp4oeGC01sssDQkMik+x7amtry/6Mm6fvPUU64ZH+pCR+;25:LTP1IAlF/g1Ycep1cFrmNTQR7vh8m7C7cWV9zowkT6eytHF0RKmiPU8VpFNO5YWWnnUmjYkqi00Bhh/lIT2/6u5HG/phTuJA+1+dfqBhSY0xexYDOBmaPp2yMkHB82VHtgg/tyCzEs3xMDfNFdE2cjkgUAHJVt8R0Rg/PGkGcqkEBStxFs92LxbqiMhuXN+iGW0+eGpUWVClnwGi6BuKRDKz8IemUUfnaKrwMmuw+lLiDT2S1Ap3rYYHWIdgS5uxKEdqMkLGq0z24e2sDkyq2GRbimyDml49yeE9iYCUY6ACLf/AUdzLb6C4LNnbZXYDwVxXN/5wAR8a5aDM+EwOZw==;31:YuKy7s8ad+W7yL8woYVBzOdz9QpGfdWrJ3CVAQ2IS9UHCb7GQPBRtFfpuyAysk68OjU+PEMsraW5cm718zvK/7GtrhtqMWcuCriKjJadjJu2BA6qbA5bwhHJnpO041hRgTf7Dod0P6/XBa/1xGEoxOsXr9pRjAv4pPXWTb4hqRnk+v4zd81ygGTHEWuBm7cGT48HXgDcp61s1PUTMiYbfqnPRYbhzMbydgqBv/4ey7o=
X-MS-TrafficTypeDiagnostic: DM5PR05MB3289:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=syeh@vmware.com;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR05MB3289;20:NcWMJbA7V+l+3neluMfLsyjpBGkH51F9QdRqwEo8SbN5ZSv7UEaWLdvMcSOnCFn84Gqfxzm8gvD6/aFt/lxoEHEo4hqVx7fWag1iiYXsnpe0M4osWD/LjdwmypFRf6NFZtt/bnKnBt9OzBwcU6ryZBkWeghekaMQL8JsgUjla2YPhphQBM2fi6V9+FFhRMBaeBVENtYsbdZZOhSKDsh1W7vse2WhYGHs49id8+D+3IhJHFqfpg+2865dGmLsjzbOvXdzVjhwLwwtcboltcYOrkVij4VyPpv6PsCJyKqCO4hchOJnfL45QrgjMFH/XpxAaAyWcXqEumr1DWnIuc9Xzd7hnhLevbJuJET/bLuB1gHAT2ewft+xp9yNK3zqqZAx7L/XWGtZ+wLWLLaL5okjyBhaSf1jBQzLHTD2VLxCdMs3zAtOkTQURhS1E1LNKU4eUrUFFozmo6iH/yYZjUOeJSShBXUEWH3zprBbV7/IHVnjVw7lrXGPZrJNfiUF9iCh;4:osQqG+QhE0LEp9QTN13mYzMSqcO8djWq0Eg4iF/eo9Ujy41KS+mU+G2JSWoTWVXrCiJa76vJZ+8GV3X3vVjZcAUQJfWYjmJHzG4OxexMzzQVAx6+WOffu1tP6w7KboHnNl3DqD6W3zrmfl7WSkF0SGDeIk9tnpCGuQMtHBOg1ux2clTw64lQ0RUqsEzbDBbvmRD6LtYdwEz13ZRokWLIWGOdBEpYWB8HjN6mMD6SLgcmG38a2V3X8EAgkqKhqj+Y2sLXWdalX9GDhyMPExQXDnnrxvag1OfJtrCQNZCjItJ0lIqbYvOlrivv76zHzlihp1iJM/ZwPJv+A0ilo1WYYIEb2icuBHRza3eSMF2EXjg=
X-Microsoft-Antispam-PRVS: <DM5PR05MB32893103AD1CEDD24D86B798A8D30@DM5PR05MB3289.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR05MB3289;BCL:0;PCL:0;RULEID:;SRVR:DM5PR05MB3289;
X-Forefront-PRVS: 06098A2863
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(6666003)(8676002)(229853002)(50466002)(2950100002)(106356001)(16586007)(58126008)(55016002)(68736007)(4326008)(81166006)(21086003)(53936002)(33656002)(86362001)(6916009)(5660300001)(6246003)(1076002)(81156014)(36756003)(33026002)(16526019)(59450400001)(186003)(23726003)(8936002)(25786009)(1411001)(39060400002)(6116002)(7736002)(69596002)(52116002)(7696005)(386003)(105586002)(97736004)(47776003)(66066001)(2906002)(478600001)(316002)(76176011)(26005)(305945005)(3846002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR05MB3289;H:vmware.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR05MB3289;23:FwHKtW4+3vWNDJ+DG6BbcDuowmSdf0tjaWsW/6ByU?=
 =?us-ascii?Q?3icpxbemxalpL5/jOWJnGRFcu4HblEyDgSsN05VvNEanRpkTgulonu70Zeva?=
 =?us-ascii?Q?BHYJq+E2nVVk1h9xImrbdVTP8VGR5iWJ2zdn26CWtXIIzDzTaZzufXCHsxKr?=
 =?us-ascii?Q?pdGq6U9SiLwEGBCnYJR/Wv7M3WDJzg+ARYWVuUg/eFMqrx0k0pox0Ld/J/wK?=
 =?us-ascii?Q?5u2DHZa+tz+NUc7lqe5wKS9PGyDpwvjwu4hYrvmyLR6YHvnkROvxLfkmbrKN?=
 =?us-ascii?Q?WC+ct/50yUL0ERzlv3kv7KuO7dmCkIWVzIj4i7OqOktlJOSrHpZ6bSYF/iq9?=
 =?us-ascii?Q?z6DjofRrxxxZWB26ioGwx6AxKj4z6USIIu8II7S0VMsVEcF53qWO+2T8Ak7s?=
 =?us-ascii?Q?+VSf975yr6YnFNbGznEKpAayeNpOA3ITHlxa9WtYg7RjIgWl3AOYZ0EfaL7A?=
 =?us-ascii?Q?cX2aC1VjyjwsOB7/O0LBeBKINWN0vj0vbeuOIlcGOq9MQUKMy1FqYWyjvVj3?=
 =?us-ascii?Q?Ci5cH/ULydA+kDN+fCYpqaV2rlaKs7NaOkEP5fzERuS63kBqjagH5f3XUJD7?=
 =?us-ascii?Q?mu4Dbfhyi+F2fDHaQb7JvjbJkEuSL7G8v7SpRaUoK4wmd2nJb5CneS/X4Sin?=
 =?us-ascii?Q?KXX2RUp9fAMK/1o5RASoSbglGYON6GeExvcJuRjSS17yHkkCYfhJNaMLqMKi?=
 =?us-ascii?Q?pmJvLzpdHgncX4YrCtH4c7EOE54+LUAHdG3kEIsHrtIF8yTAIcK+hNVhcu8E?=
 =?us-ascii?Q?M7FYydyHLifG5pwEXggOCEKwMN8gVU2byUyaclNgQu+8WBiVfctWZ3C4R7ER?=
 =?us-ascii?Q?R2LVwgtTzEyQOb0PH/eTH0MUZTMnHJQ7wy5cqviyNqdnqrD66BEu8qjGST/e?=
 =?us-ascii?Q?R+PHk+F8MUFc2T/1jw9ouD4ajZ8NrmqucUa5lvGogXugETX8tz+3Swt2EQIR?=
 =?us-ascii?Q?8tV9Lcmhm00PX8is3r6J2hmE6RoBh+Zj/iepODBv6weP+hJxEb6XDLhs5oWU?=
 =?us-ascii?Q?kClx+7MPZPBsk4utspjbvgBFNR4zVzCgm1sLbDOI1DuGhZwnZ9dRPl0dcCzI?=
 =?us-ascii?Q?X7OPq+CpR0YmwATaMYJKvbnyqEo5zWQvD5A0QIpDpcC8NoMvS7kJXa5EMK1b?=
 =?us-ascii?Q?7d3T/9gZjwSWaebm2y8aSxRGJNCyOiMJclNNlsd7UIrrW9Q382GcTulQeS8c?=
 =?us-ascii?Q?CS23tVuFtfSkNEvAyMClLzV6YOW0uvsMyaNAbAVHpVTeBzZfgILFUHJ0Afuq?=
 =?us-ascii?Q?eQ4NmENlDT+MDSBuRUW4ndfpShCX8n8jRwT/pzAunnOjEPA0jJrw8FsDeaah?=
 =?us-ascii?Q?1O6zmVc1Gie5nOJsqERMik=3D?=
X-Microsoft-Antispam-Message-Info: gRPgdBVss00aZ8IJ+ENOWyt3TAnZoyIGbOmW9O7scijsgeUsoPCnPgKLgagaTVKVM4nZucghJ+0KpegORb/8EWZIZ6nL9FX9LQN5fAGZ2nk9u6o048jYuRUU15vS96RfYc221EwILI6B7bMyyhRWdqkpxJoksfZzlN3QPREN+3MXLLrQwe8OVjddPqn1bHql
X-Microsoft-Exchange-Diagnostics: 1;DM5PR05MB3289;6:1FW6hDCoBJ7kEWgeqw0Hk1/ymdzmq1HDFRKq5C0PxpDTz7lFDtvB/2YhyBsJu1vVVHvyNkXBjsWkbofWdmOWb1WgnsK67P4H35ZLD3mD7eR60hK+6kIzuz6mhOQ5Fm11SffBgpq26bAV2HcNVcN8YtV3t2QAdP73/y2smmkEPSPai5vsMuf83U8C4UCfdvi6AZqd41k8SQ7JsnGfijVfCVOsvH1Ftm1sM2NGAP1/L562SUicgyTBF+Z+0kWh1wqfTeMBA3hQAvncW/2KN+QdT0YJ0a35Li17Z/pm/lXgYOtl+wUt32Vg5UgUM/Y8a/AjmS9fELeihfwcGYob2YIzWNHBn9litzyrjHSY+2WTTi4=;5:eNEQgQD8rv6Z/FMnT4qJcGEYsaXDEiStrXMccFt0h2r/tdkqmcFsLA+fzRy60Q7HbR7ym5ibz8gQu6ClAYYVCfIVbe+315to8Gud1yZzx1r7EPwqTuTb9C3wiPE06OXGkcu4N4ehbKzFCn3Fo9lSGGTLR7I/wsn287k+tcx5Ffo=;24:lFrlR9gPvNhjoeONHOdRm/eXkpZKI9lj4RbjYrHBN+7rcLcx56hFCQvlIzfQlkHbs13sxo/3+V6Zz8sIwNckEI4YSXjBY8vrQWHZo+IY2L8=;7:2BUBrJ5Ub4DU/stTG/WN9MrGssBU4QxJm5B1TqotyaXKqrugo5fHaUVZmyU6l7M0Cdbbimbq3kxDm5KyanOtzhe2JexsW+LOINNbZLO7dm7XduheLaWVSm9+RIkZS6ruo/0npM/nimtuZjg7Yam/baHV/LcrSTadGiR67XV+FO3SCZcnLJ+eQdR4ejgqv+e39+oh399r3pWnGDwHqLlAT79ktvtvN8n2ekHmudaiqgAD4YY2Ozj4+mP2d/zqs2x9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR05MB3289;20:jxySZbj/V6oPN8XZaHTDi66uMv8zgzyXzfdrM9vWLHRx3WpgEdQhTxWB98BM974tbD39YsPc07WX5vfpavuLczZFQTZNmHDakNpq0eyjrzfwjrOoy1G4BB9g+P2//6c6kKQ5jlU4n2NaeFxJcg413CVIK8jXcJTz4J4I7DFECsw=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2018 18:56:20.8962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7079e4-3405-4367-4047-08d5884af22a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR05MB3289
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

Reviewed-by: Sinclair Yeh <syeh@vmware.com>

On Wed, Mar 07, 2018 at 11:33:22PM +0530, Himanshu Jha wrote:
> Use kasprintf instead of combination of kmalloc and sprintf. Also,
> remove the local variables used for storing the string length as they
> are not required now.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
> index 9700099..cdff992 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
> @@ -328,7 +328,7 @@ int vmw_host_get_guestinfo(const char *guest_info_param,
>  {
>  	struct rpc_channel channel;
>  	char *msg, *reply = NULL;
> -	size_t msg_len, reply_len = 0;
> +	size_t reply_len = 0;
>  	int ret = 0;
>  
>  
> @@ -338,15 +338,12 @@ int vmw_host_get_guestinfo(const char *guest_info_param,
>  	if (!guest_info_param || !length)
>  		return -EINVAL;
>  
> -	msg_len = strlen(guest_info_param) + strlen("info-get ") + 1;
> -	msg = kzalloc(msg_len, GFP_KERNEL);
> +	msg = kasprintf(GFP_KERNEL, "info-get %s", guest_info_param);
>  	if (!msg) {
>  		DRM_ERROR("Cannot allocate memory to get %s", guest_info_param);
>  		return -ENOMEM;
>  	}
>  
> -	sprintf(msg, "info-get %s", guest_info_param);
> -
>  	if (vmw_open_channel(&channel, RPCI_PROTOCOL_NUM) ||
>  	    vmw_send_msg(&channel, msg) ||
>  	    vmw_recv_msg(&channel, (void *) &reply, &reply_len) ||
> @@ -388,7 +385,6 @@ int vmw_host_log(const char *log)
>  {
>  	struct rpc_channel channel;
>  	char *msg;
> -	int msg_len;
>  	int ret = 0;
>  
>  
> @@ -398,15 +394,12 @@ int vmw_host_log(const char *log)
>  	if (!log)
>  		return ret;
>  
> -	msg_len = strlen(log) + strlen("log ") + 1;
> -	msg = kzalloc(msg_len, GFP_KERNEL);
> +	msg = kasprintf(GFP_KERNEL, "log %s", log);
>  	if (!msg) {
>  		DRM_ERROR("Cannot allocate memory for log message\n");
>  		return -ENOMEM;
>  	}
>  
> -	sprintf(msg, "log %s", log);
> -
>  	if (vmw_open_channel(&channel, RPCI_PROTOCOL_NUM) ||
>  	    vmw_send_msg(&channel, msg) ||
>  	    vmw_close_channel(&channel)) {
> -- 
> 2.7.4
> 
